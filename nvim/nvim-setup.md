Neovim 
======

2023-10-04

I'm configuring a completely fresh neovim. I started from this guide [1]. It keeps init.lua itself pretty minimal and sits everything up into separate files:

```
nvim/lua/core/options.lua
nvim/lua/core/mappings.lua
nvim/lua/core/plugins.lua
```

Plugin-specific configs are stored in their own files:

```
nvim/after/plugin/treesitter.lua
nvim/after/plugin/colors.lua
nvim/after/plugin/telescope.lua
```

[1] https://dev.to/oinak/neovim-config-from-scratch-part-i-3o2m

Key bindings in netrw:

`-`: open netrw
`%`: create file
`d`: create directory


Tips around setting stuff up

- run `:PackerSync` after adding a new plugin
- run `:so %` to source the current file

Key bindings

`gcc`: Comment out current line
`gx`: Opens links

TODO

- [x] add keybindings
- [x] check against my sublime keybindings on my work computer
- [x] learn how to use telescope
- [x] install lualine
- [x] remember the key bindings for switching buffers and such (I probably have a file for it somewhere)
- [x] make links clickable
- [x] build a script that opens the current file in marked2 or uses `mdp` to generate the google docs html
- [ ] install https://github.com/SidOfc/mkdx
- [ ] install an LSP: https://github.com/VonHeikemen/lsp-zero.nvim#quickstart-for-the-impatient
