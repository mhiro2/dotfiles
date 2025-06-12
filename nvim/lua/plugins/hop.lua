return {
  "smoka7/hop.nvim",
  event = "VimEnter",
  keys = {
    { "w", mode = "n" },
    { "W", mode = "n" },
    { "f", mode = { "n", "x", "o" } },
    { "F", mode = { "n", "x", "o" } },
    { "t", mode = { "n", "x", "o" } },
    { "T", mode = { "n", "x", "o" } },
  },
  config = function()
    local mode = { "n", "x", "o" }
    local hop = require("hop")
    local directions = require("hop.hint").HintDirection

    vim.keymap.set("n", "w", function()
      hop.hint_words({ direction = directions.AFTER_CURSOR })
    end, { remap = true })
    vim.keymap.set("n", "W", function()
      hop.hint_words({ direction = directions.BEFORE_CURSOR })
    end, { remap = true })
    vim.keymap.set(mode, "f", function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
    end, { remap = true })
    vim.keymap.set(mode, "F", function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
    end, { remap = true })
    vim.keymap.set(mode, "t", function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
    end, { remap = true })
    vim.keymap.set(mode, "T", function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
    end, { remap = true })

    require("hop").setup()
  end,
}
