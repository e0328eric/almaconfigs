Set-Alias -Name v -Value nvim

# alias paths
function notetaking {
	set-location '~\Nextcloud\TeX_Documents\NoteTaking\'
}
function minireport {
	set-location '~\Nextcloud\TeX_Documents\Mini_Report\'
}
function teachingf {
	set-location '~\Nextcloud\TeX_Documents\TF\'
}

function cfmtcp {
    Copy-Item -Path '~\Github\arch-almagest\format\.clang-format' -Destination '.\.clang-format'
}

function make-symlink ($target, $link) {
    New-Item -Path $link -ItemType SymbolicLink -Value $target
}

Invoke-Expression (&starship init powershell)
