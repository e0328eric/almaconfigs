local M = {}

M.terminal = "kitty"
M.browser = "firefox"
M.editor = os.getenv("EDITOR") or "nvim"
M.editor_cmd = M.terminal .. " -e " .. M.editor
M.modkey = "Mod4"

return M
