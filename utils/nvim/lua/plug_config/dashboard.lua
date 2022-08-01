-- Dashboard config
local db = require('dashboard')
db.custom_header = {
"   ('-.              _   .-')      ('-.                   ('-.    .-')    .-') _   ",
"  ( OO ).-.         ( '.( OO )_   ( OO ).-.             _(  OO)  ( OO ). (  OO) )  ",
"  / . --. / ,--.     ,--.   ,--.) / . --. /  ,----.    (,------.(_)---\\_)/     '._ ",
"  | \\-.  \\  |  |.-') |   `.'   |  | \\-.  \\  '  .-./-')  |  .---'/    _ | |'--...__)",
".-'-'  |  | |  | OO )|         |.-'-'  |  | |  |_( O- ) |  |    \\  :` `. '--.  .--'",
" \\| |_.'  | |  |`-' ||  |'.'|  | \\| |_.'  | |  | .--, \\(|  '--.  '..`''.)   |  |   ",
"  |  .-.  |(|  '---.'|  |   |  |  |  .-.  |(|  | '. (_/ |  .--' .-._)   \\   |  |   ",
"  |  | |  | |      | |  |   |  |  |  | |  | |  '--'  |  |  `---.\\       /   |  |   ",
"  `--' `--' `------' `--'   `--'  `--' `--'  `------'   `------' `-----'    `--'   "
}

db.custom_center = {
  {icon = '  ',
  desc = 'Competitive                    ',
  shortcut = '\\ cc',
  action ='CphReceive'},

  {icon = '  ',
  desc = 'Find Files                     ',
  shortcut = '\\ ff',
  action ='Telescope find_files'},

  {icon = '  ',
  desc = 'Find History                   ',
  shortcut = '\\ fo',
  action ='Telescope oldfiles'},
}

local plugins_count = vim.fn.len(
    vim.fn.globpath('~/.local/share/nvim/site/pack/packer/start', '*', 0, 1)
)
db.custom_footer = {'-- Neovim Loaded ' .. plugins_count .. ' Plugins --'}

local dashboard_height = 27
db.header_pad  = math.floor((vim.api.nvim_list_uis()[1]['height'] - dashboard_height) / 4)

vim.cmd([[highlight DashboardHeader guifg=#ffffff]])

