require "nvchad.options"

vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

vim.g.clipboard = {
  name = 'wl-clipboard',
  copy = {
    ['+'] = 'wl-copy',
    ['*'] = 'wl-copy',
  },
  paste = {
    ['+'] = 'wl-paste',
    ['*'] = 'wl-paste',
  },
  cache_enabled = 1,
}

-- Atajos personalizados para copiar y pegar con Ctrl+Shift+C/V
vim.keymap.set({ "n", "v" }, "<C-S-c>", '"+y', { noremap = true, silent = true }) -- copiar
vim.keymap.set("n", "<C-S-v>", '"+p', { noremap = true, silent = true })          -- pegar en modo normal
vim.keymap.set("i", "<C-S-v>", '<C-r>+', { noremap = true, silent = true })       -- pegar en modo insert
