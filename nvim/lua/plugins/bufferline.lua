return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local bufferline = require("bufferline")

    local function hl_color(name, attr, fallback)
      local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
      if not ok or not hl then
        return fallback
      end

      local key = attr
      if attr == "fg" then
        key = "foreground"
      elseif attr == "bg" then
        key = "background"
      end

      local value = hl[attr] or hl[key]
      if value then
        return string.format("#%06x", value)
      end

      return fallback
    end

    bufferline.setup({
      options = {
        mode = "buffers",
        style_preset = {
          bufferline.style_preset.minimal,
          bufferline.style_preset.no_italic,
        },
        themable = true,
        always_show_bufferline = true,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        color_icons = true,
        get_element_icon = function(element)
          local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = true })
          return icon, hl
        end,
        separator_style = "thin",
        indicator = {
          icon = "",
          style = "icon",
        },
        show_buffer_close_icons = false,
        show_close_icon = false,
        tab_size = 22,
        max_name_length = 18,
        hover = {
          enabled = true,
          delay = 150,
          reveal = { "close" },
        },
        offsets = {
          {
            filetype = "fern",
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
          },
        },
      },
      highlights = {
        fill = {
          fg = hl_color("Comment", "fg", "#6e738d"),
          bg = hl_color("StatusLineNC", "bg", "#1f1f28"),
        },
        background = {
          fg = hl_color("Comment", "fg", "#6e738d"),
          bg = hl_color("StatusLineNC", "bg", "#1f1f28"),
        },
        buffer_selected = {
          fg = hl_color("Normal", "fg", "#f6f2ee"),
          bg = hl_color("DiffDelete", "bg", "#51A978"),
          bold = true,
        },
        buffer_visible = {
          fg = hl_color("Normal", "fg", "#c8c3bc"),
          bg = hl_color("StatusLineNC", "bg", "#1f1f28"),
        },
      },
    })
  end,
}
