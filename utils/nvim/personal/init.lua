local gretting = function()
    local signature = [[
   ___      _                    __   __    _
  /   \    | |    _ __    __ _   \ \ / /   (_)    _ __
  | - |    | |   | '  \  / _` |   \ V /    | |   | '  \
  |_|_|   _|_|_  |_|_|_| \__,_|   _\_/_   _|_|_  |_|_|_|
_|"""""|_|"""""|_|"""""|_|"""""|_| """"|_|"""""|_|"""""|
"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-']]

    print(signature)
    print()
    print("Welcome to AlmaVim!")
end

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') ..
                             '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        gretting()
        fn.system({
            'git', 'clone', '--depth', '1',
            'https://github.com/wbthomason/packer.nvim', install_path
        })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup({
    function(use)
        local plugins = require("almagest.plugins")
        for _, plugin in ipairs(plugins) do use(plugin) end

        if packer_bootstrap then
            require("packer").sync()
            require("almagest")
        else
            require("almagest")
        end
    end,
    config = {display = {open_fn = require('packer.util').float}}
})
