# vim-tmux-copy

Yank contents in a register into tmux buffer.

## What's this?

TODO: Now this plugin is only for Neovim.

With this tiny plugin, you can put contents in a register into tmux buffer. After this, you can use it with `tmux show-buffer` / `tmux paste-buffer`.

1. Yank any region in Vim.
2. Call `<Plug>TmuxCopy`. (default: <A-[>)
  * Or you can call with any register. `"a<A-[>`, `"b<A-[>`, etc.
3. Use in tmux.
  * Show contents: `tmux show-buffer`
  * Paste into window: `tmux paste-buffer` (default shortcut: `C-b ]`)

## How this works?

`<Plug>TmuxCopy` executes `tmux load-buffer` command with contents in the register. It uses job-control feature in Neovim.

## Customization

### `g:tmux_copy_map` (default: `1`)

If you set this to `0`, you can use any mapping for `<Plug>TmuxCopy` you like.

```vim
map <C-y> <Plug>TmuxCopy
```
