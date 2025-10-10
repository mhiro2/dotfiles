return {
  "smoka7/hop.nvim",
  keys = {
    {
      "w",
      function()
        local hop = require("hop")
        local directions = require("hop.hint").HintDirection
        hop.hint_words({ direction = directions.AFTER_CURSOR })
      end,
      mode = "n",
      desc = "Hop words forward",
    },
    {
      "W",
      function()
        local hop = require("hop")
        local directions = require("hop.hint").HintDirection
        hop.hint_words({ direction = directions.BEFORE_CURSOR })
      end,
      mode = "n",
      desc = "Hop words backward",
    },
    {
      "f",
      function()
        local hop = require("hop")
        local directions = require("hop.hint").HintDirection
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
      end,
      mode = { "n", "x", "o" },
      desc = "Hop to char forward",
    },
    {
      "F",
      function()
        local hop = require("hop")
        local directions = require("hop.hint").HintDirection
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
      end,
      mode = { "n", "x", "o" },
      desc = "Hop to char backward",
    },
    {
      "t",
      function()
        local hop = require("hop")
        local directions = require("hop.hint").HintDirection
        hop.hint_char1({
          direction = directions.AFTER_CURSOR,
          current_line_only = true,
          hint_offset = -1,
        })
      end,
      mode = { "n", "x", "o" },
      desc = "Hop before char forward",
    },
    {
      "T",
      function()
        local hop = require("hop")
        local directions = require("hop.hint").HintDirection
        hop.hint_char1({
          direction = directions.BEFORE_CURSOR,
          current_line_only = true,
          hint_offset = 1,
        })
      end,
      mode = { "n", "x", "o" },
      desc = "Hop before char backward",
    },
  },
  config = function()
    require("hop").setup()
  end,
}
