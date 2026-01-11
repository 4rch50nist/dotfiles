local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("spf", {
    t {
      "vector<int> spf(N + 1);",
      "iota(spf.begin() + 2, spf.end(), 2);",
      "",
      "for (int i = 2; i < N + 1; ++i) {",
      "  if (spf[i] == i) {",
      "    for (ll j = 1LL * i * i; j < N + 1; j += i)",
      "      if (spf[j] == j)",
      "        spf[j] = i;",
      "  }",
      "}",
    },
  }),
}
