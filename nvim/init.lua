-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  local result = vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
  if vim.v.shell_error ~= 0 then
    -- stylua: ignore
    vim.api.nvim_echo({ { ("Error cloning lazy.nvim:\n%s\n"):format(result), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
    vim.fn.getchar()
    vim.cmd.quit()
  end
end

vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

vim.o.background = "light"
require "lazy_setup"
require "polish"

-- This is for proper indentation on LaTeX
local cruft = vim.fn.stdpath "cache" .. "/latexindent/"
vim.fn.mkdir(cruft, "p")
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.tex",
  callback = function(args)
    local buf = args.buf
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    -- no file argument: latexindent reads stdin and prints to stdout; -c keeps indent.log out of your project
    local out = vim.fn.systemlist({ "latexindent", "-c", cruft }, lines)
    if vim.v.shell_error ~= 0 then
      vim.notify("latexindent failed:\n" .. table.concat(out, "\n"), vim.log.levels.WARN)
      return
    end
    if not vim.deep_equal(out, lines) then
      local view = vim.fn.winsaveview()
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, out)
      vim.fn.winrestview(view)
    end
  end,
})
