-- Cargar las configuraciones base de NvChad
require "nvchad.mappings"

-- Definir mapeos simples
local map = vim.keymap.set

-- Mapeos básicos
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Mapeos para el portapapeles (estos son los que funcionan)
map("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Copy line to system clipboard" })
map("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
map("n", "<leader>P", '"+P', { desc = "Paste before cursor from system clipboard" })

-- Si necesitas definir más mapeos en la estructura NvChad
local M = {}

M.general = {
  -- Si necesitas otros mapeos aquí, agrégalos
  -- Pero el mapeo <C-S-c> no es necesario ya que no funciona consistentemente
}

return M
