# env.nu
#
# Installed by:
# version = "0.102.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.

$env.PATH =  $env.PATH | prepend "/opt/homebrew/bin" | prepend "/opt/homebrew/opt/nvm/nvm.sh" | append "/usr/local/bin" | prepend "/Users/aditya/.local/bin"
 $env.PATH = ($env.PATH | prepend "/opt/homebrew/Caskroom/sqlcl/26.2.0.181.2110/sqlcl/bin")
$env.PATH = ($env.PATH | prepend "/opt/homebrew/opt/postgresql@17/bin")
$env.PATH = ($env.PATH | prepend "/Library/TeX/texbin")
$env.VIMRUNTIME = "/opt/homebrew/opt/neovim/share/nvim/runtime"
