## Mis Archivos DOT

Esta configuration se basa en usar `stow` para crear automaticamente los symlinks

La estructura de carpetas dentro de cada una refleja el path desde el home

Este respositorio esta pensado para ser clonado en el home ej `/home/alpha/.dotfiles`
Luego correr `stow nvim` y asi por cada carpeta

Configuracion de:

- NeoVIM
- Tmux
- ZSH


TO be Continued

Home Manager configuration

Install Nix
Install home manager
```
nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

Install gpu wrapper
```
nix-channel --add https://github.com/guibou/nixGL/archive/main.tar.gz nixgl
nix-channel --update
```

stow nix
in home run `home-manager build` if no error use `home-manager switch`
