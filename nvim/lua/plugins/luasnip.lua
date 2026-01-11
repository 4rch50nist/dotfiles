return {
  "L3MON4D3/LuaSnip",
  config = function()
    local ls = require "luasnip"

    -- Load snippets from ~/.config/nvim/lua/user/snippets/
    require("luasnip.loaders.from_lua").load { paths = "~/.config/nvim/lua/user/snippets" }
  end,
}
