local jdtls = require("jdtls")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function find_root()
  local markers = { "build.gradle.kts", "settings.gradle.kts", "pom.xml", ".git" }
  local path = vim.fn.expand("%:p:h")
  while path ~= "/" do
    for _, marker in ipairs(markers) do
      if vim.fn.filereadable(path .. "/" .. marker) == 1 then
        return path
      end
    end
    path = vim.fn.fnamemodify(path, ":h")
  end
  return nil
end

local root_dir = find_root()
if not root_dir then return end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_folder = vim.fn.stdpath("data") .. "/jdtls-workspaces/" .. project_name

local config = {
  cmd = { vim.fn.exepath("jdtls"), "-data", workspace_folder },
  root_dir = root_dir,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

jdtls.start_or_attach(config)

