-- aerial.nvim: drop the treesitter backend, which errors on this Neovim
return {
  "stevearc/aerial.nvim",
  opts = function(_, opts) opts.backends = { "lsp", "markdown", "man" } end,
}
