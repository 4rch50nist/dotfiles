-- Options (leader is already <Space> in AstroNvim)
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"
vim.o.swapfile = false
vim.opt.undofile = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.confirm = true
vim.opt.fillchars:append { eob = " " }

-- VimTeX: build files in .build/, PDFs in pdf/
vim.g.vimtex_compiler_latexmk = { aux_dir = ".build", out_dir = "pdf" }

-- Providers you don't use (silences four health warnings)
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- Arrow keys off in normal mode
for key, hint in pairs { ["<left>"] = "h", ["<right>"] = "l", ["<up>"] = "k", ["<down>"] = "j" } do
  vim.keymap.set("n", key, '<cmd>echo "Use ' .. hint .. ' to move!!"<CR>')
end

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Deletes and changes don't touch the clipboard
vim.keymap.set({ "n", "v" }, "d", '"_d', { desc = "Delete without yanking" })
vim.keymap.set({ "n", "v" }, "D", '"_D', { desc = "Delete to end of line without yanking" })
vim.keymap.set({ "n", "v" }, "c", '"_c', { desc = "Change without yanking" })
vim.keymap.set({ "n", "v" }, "C", '"_C', { desc = "Change to end of line without yanking" })
vim.keymap.set({ "n", "v" }, "x", '"_x', { desc = "Delete character without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>x", "d", { desc = "Cut (delete and yank)" })
vim.keymap.set("v", "p", "P", { desc = "Paste over selection without yanking it" })

-- Insert-mode escape
vim.keymap.set("i", "kk", "<Esc>", { silent = true })
local scheme_file = vim.fn.stdpath "state" .. "/background"

local function set_scheme(mode)
  vim.o.background = mode
  vim.cmd.colorscheme "mellifluous"
  vim.fn.writefile({ mode }, scheme_file)
end

vim.api.nvim_create_user_command("Scheme", function(o)
  local mode = o.args
  if mode ~= "dark" and mode ~= "light" then -- no argument: toggle
    mode = vim.o.background == "dark" and "light" or "dark"
  end
  set_scheme(mode)
end, {
  nargs = "?",
  complete = function() return { "dark", "light" } end,
  desc = "Switch the colour scheme between dark and light",
})

-- let lowercase :scheme work too
vim.cmd [[cnoreabbrev <expr> scheme getcmdtype() ==# ':' && getcmdline() ==# 'scheme' ? 'Scheme' : 'scheme']]

-- restore the last choice at startup
if vim.fn.filereadable(scheme_file) == 1 then set_scheme(vim.fn.readfile(scheme_file)[1]) end
