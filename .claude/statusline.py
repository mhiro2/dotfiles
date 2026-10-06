#!/usr/bin/env python3

import json
import sys
import time

if sys.platform == "win32":
    sys.stdout.reconfigure(encoding="utf-8")

data = json.load(sys.stdin)

BLOCKS = " ▏▎▍▌▋▊▉█"
R = "\033[0m"
DIM = "\033[2m"
GREEN = "\033[38;2;100;200;120m"
RED = "\033[38;2;230;110;110m"
YELLOW = "\033[38;2;230;190;80m"


def gradient(pct):
    if pct < 50:
        r = int(pct * 5.1)
        return f"\033[38;2;{r};200;80m"
    else:
        g = int(200 - (pct - 50) * 4)
        return f"\033[38;2;255;{max(g, 0)};60m"


def bar(pct, width=6):
    pct = min(max(pct, 0), 100)
    filled = pct * width / 100
    full = int(filled)
    frac = int((filled - full) * 8)
    b = "█" * full
    if full < width:
        b += BLOCKS[frac]
        b += "░" * (width - full - 1)
    return b


def fmt_reset(resets_at):
    if not resets_at:
        return ""
    secs = int(resets_at - time.time())
    if secs <= 0:
        return ""
    if secs < 3600:
        return f"{secs // 60}m"
    if secs < 86400:
        h, m = divmod(secs, 3600)
        m //= 60
        return f"{h}h{m}m" if m else f"{h}h"
    d, h = divmod(secs, 86400)
    h //= 3600
    return f"{d}d{h}h" if h else f"{d}d"


def fmt_tokens(n):
    if n >= 1_000_000:
        return f"{n / 1_000_000:.1f}M"
    return f"{round(n / 1000)}k"


def fmt(label, pct, reset=""):
    p = round(pct)
    s = f"{label} {gradient(pct)}{bar(pct)} {p}%{R}"
    if reset:
        s += f" {DIM}{reset}{R}"
    return s


model = data.get("model", {}).get("display_name", "Claude")
effort = data.get("effort", {}).get("level")
if effort:
    model = f"{model}{DIM}·{effort}{R}"
parts = [model]

ctx = data.get("context_window", {}).get("used_percentage")
if ctx is not None:
    parts.append(fmt("ctx", ctx))

rl = data.get("rate_limits", {})
five = rl.get("five_hour", {})
if five.get("used_percentage") is not None:
    parts.append(fmt("5h", five["used_percentage"], fmt_reset(five.get("resets_at"))))

week = rl.get("seven_day", {})
if week.get("used_percentage") is not None:
    parts.append(fmt("7d", week["used_percentage"], fmt_reset(week.get("resets_at"))))

pc = data.get("prompt_cache") or {}
if pc and pc.get("caching_observed", True):
    ttl = pc.get("ttl")
    ttl_secs = {"5m": 300, "1h": 3600}.get(ttl)
    expires = pc.get("expires_at")
    left = int(expires - time.time()) if expires else 0
    if pc.get("warm") and left > 0:
        color = YELLOW if ttl_secs and left < ttl_secs * 0.2 else GREEN
        s = f"cache {color}● {fmt_reset(expires)}{R}"
    else:
        s = f"cache {RED}○ cold"
        recache = pc.get("recache_tokens_if_cold")
        if recache:
            s += f" {fmt_tokens(recache)}"
        s += R
    misses = pc.get("misses") or 0
    if misses:
        causes = (pc.get("last_miss_cause") or {}).get("causes") or []
        s += f" {RED}miss {misses}{R}"
        if causes:
            s += f" {DIM}{','.join(causes)}{R}"
    parts.append(s)

cost = data.get("cost", {})
added = cost.get("total_lines_added", 0) or 0
removed = cost.get("total_lines_removed", 0) or 0
if added or removed:
    parts.append(f"{GREEN}+{added}{R} {RED}-{removed}{R}")

print(f"{DIM}│{R}".join(f" {p} " for p in parts), end="")
