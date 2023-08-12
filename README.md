## Dark.nvim

![dark](https://github.com/doums/dark.nvim/assets/6359431/df561063-7bea-419a-9fc3-6bf1c13b045f)

:moon: A dark colorscheme for [nvim](https://neovim.io/)

### Defined HL groups

- builtin groups (`:h highlight-groups`)
- common groups (`:h group-name`)
- Treesitter (`:h treesitter-highlight-groups`)
- builtin terminal colors
- some arbitrary [groups](https://github.com/doums/dark.nvim/blob/b0a8a76279eeb62149c5c8cfefd3026f70da073f/lua/dark/hl.lua#L35)

### Install

As usual using your plugin manager, e.g. lazy.nvim

```lua
local P = {
  'doums/dark.nvim',
  lazy = false,
  priority = 1000,
}

return P
```

Then load the colorscheme in your config

```lua
vim.cmd('colorscheme dark')
```

### Palette

The color palette is exported

```lua
local p = require('dark').p
```

### Credits

[JetBrains](https://www.jetbrains.com/) IDEs for the "Dark" theme palette

### License

Mozilla Public License 2.0
