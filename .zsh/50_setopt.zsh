# ------------------------------------------------
# Zsh Option Settings File
# ------------------------------------------------

# Uncomment to apply changes.

# - Verify options in commandline
#   $ setopt       : (print enable options)
#   $ unsetopt     : (print disable options)

# - Enabling
#   $ set -o {option}
#   $ setopt {option}

# - Disabling
#   $ unsetopt {option}
#   $ setopt no{option}
#   $ set +o option
# ------------------------------------------------

# Changing Directories {{{

# Change directory if the command doesn't exist.
set -o AUTO_CD

# Make cd push the old directory onto the directory stack.
set -o AUTO_PUSHD

# Try to expand the expression as if it were preceded by a `~'.
set -o CDABLE_VARS

# If containing a path segment '..', resolve the path to the physical directory.
#set -o CHASE_DOTS

# Change directory to a symlink is in fact cd to the true directory.
set -o CHASE_LINKS

# Make directory changing more POSIX-compatible.
#set -o POSIX_CD

# Don't push multiple copies of the same directory onto the directory stack.
set -o PUSHD_IGNORE_DUPS

# Exchanges the meanings of '+' and '-' when used with a number to specify a directory in the stack.
set -o PUSHD_MINUS

# Don't print the directory stack after pushd or popd.
set -o PUSHD_SILENT

# Have pushd with no arguments act like 'pushd $HOME'.
set -o PUSHD_TO_HOME
# }}}

# Completion {{{

# Try to return to the last prompt if given no numeric argument.
set -o ALWAYS_LAST_PROMPT
#set +o ALWAYS_LAST_PROMPT

# Move to end of word when completing.
set -o ALWAYS_TO_END

# Automatically list choices on an ambiguous completion.
set -o AUTO_LIST
#set +o AUTO_LIST

# Automatically use menu completion.
set -o AUTO_MENU
#set +o AUTO_MENU

# Use named dirs when possible
set -o AUTO_NAME_DIRS

# Complete parenthesis and a parameter name automatically.
set -o AUTO_PARAM_KEYS
#set +o AUTO_PARAM_KEYS

# If a parameter is completed whose content is the name of a directory, then add a trailing slash instead of a space.
set -o AUTO_PARAM_SLASH
#set +o AUTO_PARAM_SLASH

# Remove slash on dirs if word separator added.
#set +o AUTO_REMOVE_SLASH

# On an ambiguous completion, automatically list choices when the completion function is called twice in succession.
#set -o BASH_AUTO_LIST

# Don't replace alias before completion.
set -o COMPLETE_ALIASES

# the cursor is not set to the end of the word if completion is started
set -o COMPLETE_IN_WORD

# Don't show completions when using '*'.
set -o GLOB_COMPLETE

# Make sure the entire command path is hashed first.
set -o HASH_LIST_ALL
#set +o HASH_LIST_ALL

# Unambiguous prefix completion is done silently.
#set +o LIST_AMBIGUOUS

# Don't beep on an ambiguous completion.
set +o LIST_BEEP

# Try to make the completion list smaller (occupying less lines) by printing the matches in columns with different widths.
set -o LIST_PACKED

# Move horizontally during completion.
#set -o LIST_ROWS_FIRST

# Show types of listing files.
set -o LIST_TYPES
#set +o LIST_TYPES

# Don't autoselect the first completion entry.
set +o MENU_COMPLETE
#set -o MENU_COMPLETE

# In completion, recognize exact matches even if they are ambiguous.
set -o REC_EXACT
# }}}

# history {{{

# Append rather than overwrite history file.
set -o APPEND_HISTORY
#set +o APPEND_HISTORY

# Perform textual history expansion, csh-style, treating the character '!' specially
set -o BANG_HIST
#set +o BANG_HIST

# Save additional info to $HISTFILE.
set -o EXTENDED_HISTORY

# Add '|' to output redirections in the history.
set -o HIST_ALLOW_CLOBBER

# Don't beep at no history.
set +o HIST_BEEP

# The oldest history event that has a duplicate to be lost before losing a unique event from the list.
set -o HIST_EXPIRE_DUPS_FIRST

# Locking history file fcntl call. (better performance)
set -o HIST_FCNTL_LOCK

# When searching for history entries in the line editor, do not display duplicates of a line previously found.
set -o HIST_FIND_NO_DUPS

# If a new command line being added to the history list duplicates an older one, the older command is removed from the list.
set -o HIST_IGNORE_ALL_DUPS

# Ignore duplicate command history list.
set -o HIST_IGNORE_DUPS

# If the commandline starts with a whitespace, don't add it to history.
set -o HIST_IGNORE_SPACE

# Don't store function definitions in the history list.
set -o HIST_NO_FUNCTIONS

# Remove the history (fc -l) command from the history list when invoked.
set -o HIST_NO_STORE

# Remove superfluous blanks from each command line being added to the history list.
set -o HIST_REDUCE_BLANKS

# Don't create temporaly file to copy history.
#set +o HIST_SAVE_BY_COPY

# Avoid duplicates on history saving.
set -o HIST_SAVE_NO_DUPS

# Don't execute the line directly from the history.
set +o HIST_VERIFY
#set -o HIST_VERIFY

# New history lines are added to the $HISTFILE incrementally.
set -o INC_APPEND_HISTORY

# Share history file among all zsh sessions.
set -o SHARE_HISTORY
# }}}

# Expansion and Grobbing {{{

# If a pattern for filename generation is badly formed, print an error message.
#set +o BAD_PATTERN

# In a glob pattern, treat a trailing set of parentheses as a qualifier list, if it contains no '|','(' or (if special) '~' characters.
#set +o BARE_GLOB_QUAL

# Enable expansion from {a-c} to a b c.
set -o BRACE_CCL

# Use case-insensitive matching.
#set +o CASE_GLOB

# Make regular expressions using the zsh/regex module.
#set +o CASE_MATCH

# Use csh-like glob.
#set -o CSH_NULL_GLOB

# Expand = command to the path of the command.
set -o EQUALS
#set +o EQUALS

# Treat the '#', '~' and '^' characters as part of patterns for filename generation, etc.
set -o EXTENDED_GLOB

# Constants in arithmetic evaluation will be treated as floating point.
# set -o FORCE_FLOAT

# Perform filename generation (globbing).
#set +o GLOB

# Globbing on the right hand side.
#set -o GLOB_ASSIGN

# Don't require a leading '.' in a filename to be matched explicitly.
set -o GLOB_DOTS

# Use recursive glob expansion. (variable expansion)
#set -o GLOB_SUBST

# Substitutions using the :s and :& history modifiers are performed with pattern matching instead of string matching.
set -o HIST_SUBST_PATTERN

# Enable brace expansion.
#set -o IGNORE_BRACES

# In command typing, don't need close brace '}'.
#set -o IGNORE_CLOSE_BRACES

# Use ksh-like globbing.
#set -o KSH_GLOB

# Enable completion after = like --prefix=/usr...
set -o MAGIC_EQUAL_SUBST

# Append a trailing '/' to all directory names resulting from filename generation (globbing)
set -o MARK_DIRS

# Enable multibyte characters.
#set +o MULTIBYTE

# If a pattern for filename generation has no matches, print an error.
#set +o NOMATCH

# If a pattern for filename generation has no matches, delete the pattern from the argument list instead of reporting an error.
#set -o NULL_GLOB

# Use numeric sort instead of alphabetic sort.
set -o NUMERIC_GLOB_SORT

# Enable array expansions.
#set -o RC_EXPAND_PARAM

# The '=~' operator will use Perl-Compatible Regular Expressions.
#set +o REMATCH_PCRE

# Disables the special meaning of '(', '|', ')' and '<' for globbing.
#set -o SH_GLOB

# Treat unset parameters as if they were empty when substituting.
set -o UNSET
#set +o UNSET

# Print a warning message when a global parameter is created in a function by an assignment.
#set -o WARN_CREATE_GLOBAL
# }}}

# Initialization {{{

# Export all valiables automatically.
#set -o ALL_EXPORT

# Local variables are not globale ones.
#set +o GLOBAL_EXPORT

# Ignore startup files in /etc. (except /etc/zshenv)
#set +o GLOBAL_RCS

# Ignore startup files in anywhere. (except /etc/zshenv)
#set +o RCS
# }}}

# Input/Output {{{

# Expand aliases.
set -o ALIASES
#set +o ALIASES

# Allows '>' redirection to truncate existing files, and '>>' to create files. Otherwise '>!' or '>|' must be used to truncate a file, and '>>!' or '>>|' to create a file.
set +o CLOBBER

# Try to correct the spelling of commands.
set -o CORRECT

# Try to correct the spelling of all arguments in a line.
#set -o CORRECT_ALL

# Use Dvorak mapping during error correction.
#set -o DVORAK

# No follow control by ^S and ^Q.
set +o FLOW_CONTROL

# Disable ^D to exit shell.
set -o IGNORE_EOF

# Allow comments even in interactive shells.
set -o INTERACTIVE_COMMENTS

# Subsequent invocations of the same command will use the saved location, avoiding a path search.
set -o HASH_CMDS
#set +o HASH_CMDS

# Whenever a command name is hashed, hash the directory containing it, as well as all directories that occur earlier in the path.
#set +o HASH_DIRS

# Check that the file to be hashed is actually an executable.
set -o HASH_EXECUTABLES_ONLY

# Print a warning message if a mail file has been accessed since the shell last checked.
set -o MAIL_WARNING

# Perform a path search even on command names with slashes in them.
set -o PATH_DIRS

# The script does not specify a directory path, the script is looked for first in the current directory.
#set -o PATH_SCRIPT

# Enable file names using 8 bits, important to rendering Japanese file names.
set -o PRINT_EIGHTBIT

# Print the exit value of programs with non-zero exit status.
set -o PRINT_EXIT_VALUE

# Allow the character sequence "''" to signify a single quote within singly quoted str.
#set -o RC_QUOTES

# Do not query the user before executing 'rm *' or 'rm path/*'.
#set -o RM_STAR_SILENT

# If querying the user before executing 'rm *' or 'rm path/*', first wait ten seconds and ignore anything typed in that time.
#set -o RM_STAR_WAIT

# Allow the short forms of for, repeat, select, if, and function constructs.
set -o SHORT_LOOPS
#set +o SHORT_LOOPS

# If a line ends with a backquote, and there are an odd number of backquotes on the line, ignore the trailing backquote.
#set -o SUN_KEYBORD_HACK
# }}}

# Job Control {{{

# Stopped jobs that are removed from the job table with the disown builtin command are automatically sent a CONT signal.
set -o AUTO_CONTINUE

# Resume the command if the command is suspended.
set -o auto_resume

# Run all background jobs at a lower priority.
#set +o BG_NICE

# Report the status of background and suspended jobs before exiting a shell.
#set +o CHECK_JOBS

# Send the HUP signal to running jobs when the shell exits.
#set +o HUP

# List jobs in the long format by default.
set -o LONG_LIST_JOBS

# Allow job control.
#set -o monitor

# Report the status of background jobs immediately.
set -o NOTIFY
#set +o NOTIFY

# Make job control more POSIX compliant.
#set -o POSIX_JOBS
# }}}

# Prompting {{{

# '!' is treated specially in prompt expansion.
#set -o PROMPT_BANG

# Don't print a carriage return just before printing a prompt in the line editor.
#set +o PROMPT_CR

# The shell parameter PROMPT_EOL_MARK can be used to customize how the end of partial lines are shown.
#set +o PROMPT_SP

# '%' is treated specially in prompt expansion.
#set +o PROMPT_PERCENT

# Expand parameters in the prompt.
set -o PROMPT_SUBST

# Remove any right prompt from display when accepting a command line.
set -o TRANSIENT_RPROMPT
# }}}

# Scripts and Functions {{{

#set -o C_BASES
#set -o C_PRECEDENCES
#set -o DEBUG_BEFORE_CMD
#set -o ERR_EXIT
#set -o ERR_RETURN
#set +o EVAL_LINEZO
#set +o EXEC
#set +o FUNCTION_ARG_ZERO
#set -o LOCAL_OPTIONS
#set -o LOCAL_TRAPS
#set +o MULTI_FUNC_DEF
#set +o MULTIOS
#set -o OCTAL_ZEROES
#set -o SOURCE_TRACE
#set -o TYPESET_SILENT
#set -o VERBOSE
#set -o XTRACE
# }}}

# Shell Emulation {{{

#set -o BASE_REMATCH
#set -o BSD_ECHO
#set -o CONTINUE_ON_ERROR
#set -o CSH_JUNKIE_HISTORY
#set -o CSH_JUNKIE_LOOPS
#set -o CSH_JUNKIE_QUOTES
#set -o CSH_NULLCMD
#set -o KSH_ARRAYS
#set -o KSH_AUTOLOAD
#set -o KSH_OPTION_PRINT
#set -o KSH_TYPESET
#set -o KSH_ZERO_SUBSCRIPT
#set -o POSIX_ALIASES
#set -o POSIX_BUILTINS
#set -o POSIX_INDENTIFIERS
#set -o POSIX_STRINGS
#set -o POSIX_TRAPS
#set -o SH_FILE_EXPANSION
#set -o SH_NULLCMD
#set -o SH_OPTION_LETTERS
#set -o SH_WORD_SPLIT
#set -o TRAPS_ASYNC
# }}}

# Shell State {{{

#set -o INTERACTIVE
#set -o LOGIN
#set -o PRIVILEGED
#set -o RESTRICTED
#set -o SHIN_STDIN
#set -o SINGLE_COMMAND
# }}}

# Zle {{{

# Don't beep on error.
set +o BEEP
#set -o BEEP

# Show special character correctly.
#set +o COMBINING_CHARS

# Use emacs key bindings.
#set -o EMACS

# Use Overstrike mode.
#set -o OVERSTRIKE

# Use single line edit.
#set -o SINGLE_LINE_ZLE

# Use vi key bindings.
#set -o VI

# Use zsh line editor.
#set -o ZLE
# }}}

