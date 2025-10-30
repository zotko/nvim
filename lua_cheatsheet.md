# Neovim Lua API Cheat Sheet

> Core Lua interfaces for Neovim — functions & meanings

## Top‑Level Modules

| Namespace | Description |
|---|---|
| `vim` | Root Neovim Lua module (always loaded) |
| `vim.api` | Direct access to Neovim API functions (nvim_*) |
| `vim.fn` | Call Vimscript functions |
| `vim.cmd` | Execute Ex commands |
| `vim.keymap` | Keymap helpers |
| `vim.loop` / `vim.uv` | LibUV async I/O |
| `vim.opt`, `vim.opt_local`, `vim.opt_global` | Options interfaces |
| `vim.g` | Global variables |
| `vim.b`, `vim.w`, `vim.t` | Buffer, window, tabpage vars |
| `vim.v` | v: variables |
| `vim.diagnostic` | LSP diagnostics API |
| `vim.lsp` | LSP client APIs |
| `vim.inspect` | Pretty‑print Lua values |
| `vim.print` | Print with inspect |
| `vim.schedule`, `vim.schedule_wrap` | Queue functions in main loop |
| `vim.notify` | Notification popup |

---

## Common `vim` Helpers

| Function | Description |
|---|---|
| `vim.inspect(v)` | Pretty print values |
| `vim.print(...)` | Print inspected values |
| `vim.trim(str)` | Trim whitespace |
| `vim.split(str, sep)` | Split string |
| `vim.deepcopy(val)` | Deep copy Lua table |
| `vim.tbl_contains(t, v)` | Check value in table |
| `vim.tbl_extend(mode, ...)` | Merge tables |
| `vim.tbl_filter(fn, t)` | Filter table |
| `vim.tbl_map(fn, t)` | Map over table |
| `vim.wait(ms, cond)` | Wait until condition true |
| `vim.notify(msg, level?)` | Show notification |

---

## `vim.api` Core (prefix `nvim_`)

| Function | Description |
|---|---|
| `nvim_set_keymap()` / `vim.keymap.set()` | Set keymap |
| `nvim_get_current_buf()` | Get current buffer |
| `nvim_buf_get_lines(buf, start, end, strict)` | Get buffer lines |
| `nvim_buf_set_lines(...)` | Set buffer lines |
| `nvim_list_bufs()` | List buffers |
| `nvim_get_current_win()` | Current window |
| `nvim_win_set_cursor(win, pos)` | Move cursor |
| `nvim_get_option()` / `nvim_set_option()` | Get/set options |
| `nvim_create_autocmd()` | Create autocommand |
| `nvim_create_user_command()` | Define user command |
| `nvim_open_win(...)` | Open floating window |
| `nvim_exec2()` / `vim.cmd()` | Execute Ex commands |

---

## Options API

| API | Purpose |
|---|---|
| `vim.o.<name>` | Global options |
| `vim.bo.<name>` | Buffer options |
| `vim.wo.<name>` | Window options |
| `vim.opt.<name>` | Modern interface (supports tables) |

Example:
```lua
vim.opt.number = true
vim.opt.clipboard:append("unnamedplus")
```

---

## Variables

| Namespace | Meaning |
|---|---|
| `vim.g` | Global vars |
| `vim.b` | Buffer vars |
| `vim.w` | Window vars |
| `vim.t` | Tabpage vars |
| `vim.v` | Vimscript v: variables |

---

## Command / Function Execution

| API | Description |
|---|---|
| `vim.cmd("...")` | Run Ex command |
| `vim.fn.<func>(...)` | Call Vimscript function |
| `vim.call(name, args)` | Call Vimscript by string |

---

## Keymaps

| Function | Description |
|---|---|
| `vim.keymap.set(mode, lhs, rhs, opts?)` | Define keymap |
| `vim.keymap.del(mode, lhs, opts?)` | Remove keymap |

Example:
```lua
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
```

---

## Async / Scheduling

| API | Purpose |
|---|---|
| `vim.schedule(fn)` | Run later |
| `vim.schedule_wrap(fn)` | Wrap callback to safe context |
| `vim.loop` / `vim.uv` | Low‑level async I/O |

---

## Diagnostics / LSP (brief)

| API | Description |
|---|---|
| `vim.lsp.buf.hover()` | LSP hover |
| `vim.lsp.buf.definition()` | Go to definition |
| `vim.diagnostic.open_float()` | Show diagnostics |
| `vim.diagnostic.set()` | Set diagnostics |

---

## Quick Inline Commands

```vim
:lua print("hi")
:luafile %       " run current file
:lua vim.cmd("edit foo.txt")
```

---

## Basics When Starting

- Use `init.lua` instead of `init.vim`
- Put modules in `lua/` folder
- Cache modules with `require()`

```lua
local mymod = require("mymodule")
```
---

# Neovim Lua API Guide — Key Functions Summary

## 1. Running Vim commands from Lua

* `vim.cmd(...)` — run arbitrary Vim commands from Lua. ([Neovim][1])

  ```lua
  vim.cmd("colorscheme habamax")
  vim.cmd([[
    highlight Error guibg=red
    highlight link Warning Error
  ]])
  ```
* Alternate form: access `vim.cmd.*` as functions with arguments:

  ````lua
  vim.cmd.colorscheme("habamax")
  vim.cmd.highlight({ "Error", "guibg=red" })
  ``` :contentReference[oaicite:2]{index=2}  
  ````

## 2. Calling Vimscript functions from Lua

* `vim.fn` — table that gives access to Vimscript functions (including user-defined) from Lua. ([Neovim][1])

  ```lua
  print(vim.fn.printf('Hello from %s', 'Lua'))
  local reversed = vim.fn.reverse({ 'a', 'b', 'c' })
  vim.print(reversed)  --> { "c", "b", "a" }
  ```
* For Vimscript functions whose names contain characters invalid in Lua identifiers (like `#`):

  ````lua
  vim.fn['my#autoload#function']()
  ``` :contentReference[oaicite:4]{index=4}  
  ````

## 3. Variables (global, buffer, window, tabpage etc)

* Use the wrappers to get/set scopes:

  * `vim.g` — global variables (Vimscript `g:`) ([Neovim][1])
  * `vim.b` — current buffer variables (`b:`) ([Neovim][1])
  * `vim.w` — window variables (`w:`) ([Neovim][1])
  * `vim.t` — tab-page variables (`t:`) ([Neovim][1])
  * `vim.v` — predefined Vim variables (`v:`) ([Neovim][1])
  * `vim.env` — environment variables in the editor session ([Neovim][1])
* Example:

  ````lua
  vim.g.some_global_variable = { key1 = "value", key2 = 300 }
  vim.print(vim.g.some_global_variable)  --> { key1 = "value", key2 = 300 }
  ``` :contentReference[oaicite:11]{index=11}  
  ````
* Important note: you *cannot* mutate fields of a variable directly via `vim.g.var.key = …`, because that acts on a copy. Instead:

  ````lua
  local temp = vim.g.some_global_variable
  temp.key2 = 400
  vim.g.some_global_variable = temp
  ``` :contentReference[oaicite:12]{index=12}  
  ````
* To delete a variable, set it to `nil`:

  ````lua
  vim.g.myvar = nil
  ``` :contentReference[oaicite:13]{index=13}  
  ````

## 4. Options (like `:set`)

* Two main ways in Lua:

  * `vim.opt.*` — more ergonomic for global/local options. ([Neovim][1])

    ```lua
    vim.opt.smarttab = true
    vim.opt.wildignore = { '*.o', '*.a', '__pycache__' }
    vim.opt.listchars = { space = '_', tab = '>~' }
    vim.opt.formatoptions = { n = true, j = true, t = true }
    ```

    And you can append/prepend/remove list-style options:

    ````lua
    vim.opt.shortmess:append({ I = true })
    vim.opt.wildignore:prepend('*.o')
    vim.opt.whichwrap:remove({ 'b', 's' })
    ``` :contentReference[oaicite:15]{index=15}  
    To *read* a value:  
    ```lua
    local val = vim.opt.smarttab:get()
    ````
  * `vim.o`, `vim.go`, `vim.bo`, `vim.wo` — more direct but less ergonomic. ([Neovim][1])

    ```lua
    vim.o.smarttab = false  -- equivalent to :set nosmarttab
    print(vim.o.smarttab)
    vim.bo.shiftwidth = 4    -- buffer scopes
    ```

## 5. Mappings (keybinds)

* `vim.keymap.set({mode}, lhs, rhs, opts?)` — versatile way to set key mappings in Lua. ([Neovim][1])

  * `mode`: string or list of mode identifiers (`"n"` for normal, `"i"` for insert, etc)
  * `lhs`: key sequence string
  * `rhs`: either a string (Vim command) or a Lua function
  * `opts`: optional table containing mapping options
* Example mappings:

  ````lua
  vim.keymap.set('n', '<Leader>ex1', '<cmd>echo "Example 1"<cr>')
  vim.keymap.set({'n','c'}, '<Leader>ex2', '<cmd>echo "Example 2"<cr>')
  vim.keymap.set('n', '<Leader>ex3', vim.treesitter.start)
  vim.keymap.set('n', '<Leader>ex4', function() print('Example 4') end)
  ``` :contentReference[oaicite:18]{index=18}  
  ````
* Example of mapping a plugin action:

  ````lua
  vim.keymap.set('n', '<Leader>pl1', require('plugin').action)
  vim.keymap.set('n', '<Leader>pl2', function() require('plugin').action() end)
  ``` :contentReference[oaicite:19]{index=19}  
  ````
* Useful options in `opts` table:

  * `buffer`: set mapping only for a given buffer number (`true` means current)

    ````lua
    vim.keymap.set('n', '<Leader>pl1', require('plugin').action, { buffer = true })
    ``` :contentReference[oaicite:20]{index=20}  
    ````
  * `silent`: suppress output / error messages
  * `expr`: mapping uses expression result instead of executing rhs

    ````lua
    vim.keymap.set('c', '<down>', function()
      if vim.fn.pumvisible() == 1 then return '<c-n>' end
      return '<down>'
    end, { expr = true })
    ``` :contentReference[oaicite:21]{index=21}  
    ````
  * `desc`: description string for listing mappings (recommended for plugin authors)

    ````lua
    vim.keymap.set('n', '<Leader>pl1', require('plugin').action,
      { desc = 'Execute action from plugin' })
    ``` :contentReference[oaicite:22]{index=22}  
    ````
  * `remap`: by default `false` (non-recursive mapping). To allow recursion: `remap = true`. ([Neovim][1])
* To delete a mapping:

  ````lua
  vim.keymap.del('n', '<Leader>ex1')
  vim.keymap.del({'n','c'}, '<Leader>ex2', { buffer = true })
  ``` :contentReference[oaicite:24]{index=24}  
  ````

## 6. Autocommands (aka autocmd)

* Create autocommands with `vim.api.nvim_create_autocmd(event(s), opts)` — these are triggered by events like file read/write etc. ([Neovim][1])

  * `event`: string or list of strings of events (e.g., `"BufEnter"`, `"BufWinEnter"`)
  * `opts`: table with options such as `pattern`, `callback` or `command`, `buffer`, `desc`, `group`, etc.
* Example:

  ```lua
  vim.api.nvim_create_autocmd({"BufEnter","BufWinEnter"}, {
    pattern = {"*.c","*.h"},
    command = "echo 'Entering a C or C++ file'",
  })
  ```

  Or with Lua callback:

  ````lua
  vim.api.nvim_create_autocmd({"BufEnter","BufWinEnter"}, {
    pattern = {"*.c","*.h"},
    callback = function() print("Entering a C or C++ file") end,
  })
  ``` :contentReference[oaicite:26]{index=26}  
  ````
* Inside a callback, you’ll receive a table `args` with keys such as:

  * `args.match`: the string matched the pattern
  * `args.buf`: buffer number where triggered
  * `args.file`: filename of buffer where triggered
  * `args.data`: table with other relevant data (for some events) ([Neovim][1])
* Buffer-local autocommand (via `buffer` option instead of `pattern`):

  ````lua
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = 0,
    callback = function() print("hold") end,
  })
  ``` :contentReference[oaicite:28]{index=28}  
  ````
* You can add `desc` for description:

  ````lua
  vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.hl.on_yank() end,
    desc = "Briefly highlight yanked text"
  })
  ``` :contentReference[oaicite:29]{index=29}  
  ````
* **Groups**: to organize/autoclear autocommands you can use `vim.api.nvim_create_augroup(name, opts)` which returns a group identifier. Then pass that via `group = <id or name>` in `opts`. ([Neovim][1])
  Example:

  ````lua
  local mygroup = vim.api.nvim_create_augroup('vimrc', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufNewFile','BufRead' }, {
    pattern = '*.html',
    group   = mygroup,
    command = 'set shiftwidth=4',
  })
  vim.api.nvim_create_autocmd({ 'BufNewFile','BufRead' }, {
    pattern = '*.html',
    group   = 'vimrc',
    command = 'set expandtab',
  })
  ``` :contentReference[oaicite:31]{index=31}  
  ````
* To delete/clear autocommands:

  ````lua
  vim.api.nvim_clear_autocmds({ event = {"BufEnter","InsertLeave"} })
  vim.api.nvim_clear_autocmds({ pattern = "*.py" })
  vim.api.nvim_clear_autocmds({ group = "scala" })
  vim.api.nvim_clear_autocmds({ event = "ColorScheme", buffer = 0 })
  ``` :contentReference[oaicite:32]{index=32}  
  ````
* To get/list autocommands (read-only) you can use:

  * `vim.api.nvim_get_autocmds()` — returns matching autocommands
  * `vim.api.nvim_exec_autocmds()` — execute matching autocommands manually ([Neovim][1])

## 7. User Commands

* Create custom commands with `vim.api.nvim_create_user_command(name, command_or_callback, opts)` ([Neovim][1])

  * `name`: string, must start with uppercase to distinguish from built-ins
  * `command_or_callback`: either a Vim command string or a Lua function to execute
  * `opts`: table of attributes (mandatory even if empty)

    * e.g., `desc`, `force` (to overwrite existing command), `preview` (Lua function for `:command-preview`), `nargs`, `complete`, etc.
* Example:

  ````lua
  vim.api.nvim_create_user_command('Test', 'echo "It works!"', {})
  vim.cmd.Test()  --> It works!
  ``` :contentReference[oaicite:35]{index=35}  
  Another example with Lua callback and arguments:  
  ```lua
  vim.api.nvim_create_user_command('Upper',
    function(opts)
      print(string.upper(opts.fargs[1]))
    end,
    { nargs = 1 })
  vim.cmd.Upper('foo') --> FOO
  ``` :contentReference[oaicite:36]{index=36}  
  ````
* Buffer-local user command: `vim.api.nvim_buf_create_user_command(bufnr, name, command_or_callback, opts)` ([Neovim][1])

  ```lua
  vim.api.nvim_buf_create_user_command(0, 'Upper',
    function(opts)
      print(string.upper(opts.fargs[1]))
    end,
    { nargs = 1 })
  ```
* Deleting user commands:

  ````lua
  vim.api.nvim_del_user_command('Upper')
  vim.api.nvim_buf_del_user_command(4, 'Upper')
  ``` :contentReference[oaicite:38]{index=38}  
  ````

---

## Notes & caveats

* The guide is **not** a complete list of *all* available functions in NeoVim’s Lua ecosystem; it’s a “survival kit” covering the most common / convenient ones. ([Neovim][1])
* There are three layers of API in NeoVim:

  1. Vim (legacy) commands/functions and user-functions (via `vim.cmd`, `vim.fn`)
  2. The Nvim API (written in C; accessed via `vim.api.*`) ([Neovim][1])
  3. The Lua-specific API (via `vim.*` domain, not necessarily `vim.api.*`) ([Neovim][1])
* Important indexing note: some APIs (especially Nvim API) still expect arguments exactly (even if Lua allows defaults) and may use 0-based indexing (buffers/windows) whereas Lua tables are 1-based by default. ([Neovim][1])

---

If you like, I can **generate links** for *every* relevant function in the guide (with clickable anchors) and produce a full `.md` file (including table of contents, code blocks, cross-links). Do you want me to do that?

