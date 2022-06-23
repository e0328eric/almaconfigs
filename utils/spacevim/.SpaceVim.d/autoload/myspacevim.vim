function! myspacevim#before() abort
    let g:UltiSnipsExpandTrigger="<C-]>"
    let g:UltiSnipsJumpForwardTrigger="<C-]>"
    let g:UltiSnipsJumpBackwardTrigger="<C-S-]>"
    let g:UltiSnipsUsePythonVersion = 3
    let g:UltiSnipsSnippetDirectories=['~/.config/nvim/snips']
    let g:python_highlight_all = 1

    call SpaceVim#custom#SPC('nore', ['/'], ':let @/=""<CR>', 'clear search highlights', 1)
endfunction

function! myspacevim#after() abort
endfunction
