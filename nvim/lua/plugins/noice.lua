return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter", -- needs markdown + markdown_inline parsers
  },
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
      -- disable these two — astrolsp owns them
      hover = { enabled = false },
      signature = { enabled = false },
    },
    presets = {
      lsp_doc_border = true,
    },
  },
}
