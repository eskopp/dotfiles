require("config.options")
require("config.keymaps")
require("config.lazy")

local theme_file = (os.getenv("XDG_CONFIG_HOME") or (vim.fn.expand("~") .. "/.config")) .. "/theme-switcher/current/nvim-theme.lua"

if vim.fn.filereadable(theme_file) == 1 then
  local ok, err = pcall(dofile, theme_file)
  if not ok then
    vim.schedule(function()
      vim.notify("Failed to load theme file: " .. err, vim.log.levels.WARN)
    end)
  end
end
