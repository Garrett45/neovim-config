# My Neovim Configuration

I like using neovim as a text editor in my day to day work. This is my configuration to make that happen. My goals were as follows:

## Why use Neovim?

It may be strange to see someone using Neovim these days. It can be a bit of an obtuse editor, and getting things to work how you like does generally require some elbow grease. So, why am I using it? I like Neovim because: 

1. Since it opens fast and gets out of the way, it can be great for jumping into weird, out there files that I need to handle that may not necessarily be open in one of my heavy weight IDEs. 

2. Since it's hackable and easy to modify, I can also usually get things working exactly as I want.

For these 2 reasons, it is absolutely fantastic to use as a text editor, like VS Code, in my workflow. However, neovim out of the box is missing some critical features that I really want/need to feel at home/comfortable using it. This configuration I've setup is intended to add in those features, so I can quickly clone it wherever I need it and get up and running with a simple text editor fast

## Goals

So, these are the goals of my config:

1. **Keep it fast**. This should open fast, and it should run fast. It's a text editor, so it should get my file to me and get out of the way

2. **Get normal text editor quality of life**. I want/expect the normal quality of life that I get from text editors like VS Code. This means a reasonable file explorer (netrw ain't doing it for me), support for git, good higlighting/semantic support, auto completion, and linting

3. **Make it somewhat pretty**. If I'm gonna look at this a bunch, I'd rather it at least look pretty good. Default neovim is not bad looking, but it leaves something to be desired

## Requirements

* Neovim 0.11.0 or later

* A terminal emulator. It works best if this terminal emulator has a colorscheme of Catppucin Mocha set to match neovim, but it is not required

* A nerd font that you are using in your terminal emulator. The original config uses "JetBrains Mono Nerd Font". I specifically use a Nerd Font without a "Mono" or "Propo" suffix, which is relevant to some configs

* `tar` in your path (for Windows, default alias in Powershell works)

* `curl` in your path (for Windows, default alias in Powershell works)

* `tree-sitter-cli` (this can be hairy to install on Windows. See 'Installing `tree-sitter-cli` on Windows below)

* A C compiler in your path (this is kind of required for Rust anyway, so this shouldn't be a big deal)

* `git` >= 2.19.0 in your path

* (OPTIONAL) [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep) for faster file and pattern search from picker
  
  * [sharkdp/fd](https://github.com/sharkdp/fd) can be used as an alternative. This will be fallen back to if installed instead of ripgrep (but only works for file search). If both are installed, ripgrep will be used
  
  * If neither of these are installed, git is used for file searching and grepping

* (OPTIONAL) LSPs for all languages listed in `lsp.lua` (if you decide not to install these, you will not have LSP support for the specific language that LSP covers. These LSPs need to be installed globally on your path so nvim can access it)
  
  * [clangd lsp](https://clangd.llvm.org/installation.html) - for C/C++ development
  
  * [lua-language-server](https://github.com/luals/lua-language-server) - for lua development (important for messing with this config)
  
  * [rust-analyzer](https://github.com/rust-lang/rust-analyzer) - for Rust development
  
  * [roslyn](https://github.com/dotnet/roslyn) - for C#/.NET development. Omisharp is outdated and not performant, csharp_ls has less features than both despite better performance. Tying into the official compiler for .NET makes the most sense to me. Not the simplest to install will probably need to use the [instructions on the nvim-lspconfig all configs page](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#roslyn_ls) to install it properly. Have been considering adding [seblyng/roslyn.nvim](https://github.com/seblyng/roslyn.nvim) for even better .NET support
  
  * eslint - The [instructions on the nvim-lspconfig all configs page](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#eslint) recommend installing all of [hrsh7th/vscode-langservers-extracted](https://github.com/hrsh7th/vscode-langservers-extracted). I'd agree with this advice, though it means you're not just installing the eslint server
  
  * [typescript-go lsp](https://github.com/microsoft/typescript-go) - we may have eslint, but that only provides basic support for normal linting. This is the meat and potatoes of linting for most JavaScript/TypeScript development experiences
  
  * [gopls](https://github.com/golang/tools/tree/master/gopls) - the official lsp for go
  
  * [sqls](https://github.com/sqls-server/sqls) - still actively being developed, but provides some decent support for writing SQL in neovim. May be removed at some point, as I don't really write SQL in neovim, but it's here for now. [Kurren123/mssql.nvim](https://github.com/Kurren123/mssql.nvim) might be interesting to add since I do work with SQL server a good amount, but its not exactly supported

### Installing `tree-sitter-cli` on Windows

> The relevant packages and rust platform do change if your architecture is arm instead

Installing `tree-sitter-cli` on Windows is difficult, because `x86_64-pc-windows-msvc` is the default platform, and that is not support by [DelSkayn/rquickjs](https://github.com/DelSkayn/rquickjs), which is one of the dependencies of `tree-sitter-cli`. While support for msvc is experimental, it has not worked in my experience. 

What you will need to do to install it how I did in the original build is to first install rust using `rustup`, and to set the backend platform during install to `x86_64-pc-windows-gnu` (if you already have rust installed, I believe you can just change the target platform using `--target`, so follow the rest of the instructions and add `--target` at the end).

After that, install [MSYS2](https://www.msys2.org/), and to run the following commands in the `MSYS2 UCRT64` environment (this is just the environment recommended for general development), which will install `gcc` and `clang`

```bash
pacman -Syu
pacman -S mingw-w64-ucrt-x86_64-gcc
pacman -S mingw-w64-ucrt-x86_64-clang
```

In any case, assuming you installed MSYS2 to the default location of `C:\msys64` you will then need to add `C:\msys64\ucrt64\bin` to your path. Finally, you can run the following command (the environment variable is because `rquickjs` won't be able to determine where clang is by default, you could add that environment variable as well)

```powershell
$env:LIBCLANG_PATH="C:\msys64\ucrt64\bin"; cargo install tree-sitter-cli
```

Since this also covers getting you a compiler on your path, and MSYS can be nice to have, this is a decent way to go about it. However, I later learned that `tree-sitter-cli` also [releases pre-built binaries on GitHub](https://github.com/tree-sitter/tree-sitter/releases). You could just install one of those and get a c compiler in any other way you'd like

## Packages and their Reasons for Being Here

Following with my "keep it fast" goal, I need to have a strong reason for every plugin I bring in, as each new plugin brings in more performance overhead. This list here keeps me honest by forcing me to list out a specific reason I need each plugin:

* [folke/lazy.nvim](https://github.com/folke/lazy.nvim)  - while `vim.pack` is mostly stable, and I could be using it as my plugin manager, `lazy.nvim` provides a more erganomic experience, does not add much in the way of overhead, and makes another one of the plugins here, `blink-cmp`, WAY easier to manage

* [catppuccin/nvim](https://github.com/catppuccin/nvim) - just wanted a better color scheme, like this one in general. Very little overhead, easily justifiable

* [stevearc/oil.nvim](https://github.com/stevearc/oil.nvim) - need some file explorer and this is much better than netrw. May want to replace this with an actual file tree, even though the buffer movements are NICE

* [malewicz1337/oil-git.nvim](https://github.com/malewicz1337/oil-git.nvim) - just a nice extension to oil, wanna get an idea of whats changed, whats new, so on, just like VS Code. This gives a nice overview

* [nvim-mini/mini.indentscope](https://github.com/nvim-mini/mini.indentscope) - its nice to see what level of indent I'm at, and this does it without blocking up my editing and without introducing too much visual clutter, real nice

* [nvim-mini/mini.pick](https://github.com/nvim-mini/mini.pick) - having something like JetBrains' double shift click to find files was really important to me, and this provides that. Its also fast, and on top of that, makes all selects throughout VIM nicer, gives a nice way to swap between buffers, and also improves searching for help files

* [nvim-mini/mini.statusline](https://github.com/nvim-mini/mini.statusline) - the default status line doesn't look too good, and this continues making git info easily accessible. Less justifiable, but I think that its pulling its weight enough by making the info easier to read

* [nvim-mini/mini.clue](https://github.com/nvim-mini/mini.clue) - this one is not strictly necessary, and isn't the prettiest, but I haven't used vim for the longest, and this gives an easy way to remember keybinds if I'm struggling. Since it only shows up if I linger on my command, it doesn't introduce too much visual clutter while bringing me some much needed functionality

* [saghen/blink.cmp](https://github.com/saghen/blink.cmp) - nvim may have an autocomplete built into it now, but the external Rust binary on this one supposedly makes it faster. Further, this one can actually pull up documentation with the auto complete, which is a handy feature in the JetBrains IDEs I love. It also gives extra matches that are nice like paths. If I can ever remove this, it could also be a good reason to get rid of `lazy.nvim`, but we'll see how things progress

* [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - this is from the neovim team, so this is basically an official plugin. While not needed, the premade configs make setting up LSPs much easier. I'm not including mason or mason-lspconfig on top, because its easy enough to intsall the LSPs, and having them installed means you have more control if you need it, which could be nice. I also just don't want to weigh down my install for a one time thing, particularly when I already have to deal with getting other pre-requisites squared away anyways. In any case, this provides linting, formatting, auto complete, and other error checking. Basically all the stuff you get with a normal VS Code plugin

* [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - treesitter can be done without this, but its very difficult, and you won't have nearly as nice of query files to work with, so this is just kind of needed. This provides fast and nice highlighting, along with code folding, and potentially indenting in the future (though indenting is experimental)
  
  * I am NOT USING THIS, but I could use the following repo [MeanderingProgrammer/treesitter-modules.nvim](https://github.com/MeanderingProgrammer/treesitter-modules.nvim) if I ever feel the need to get auto install back, but explicitly setting up different languages, like I have to do for LSP anyways, is not the end of the world, it means I won't get a bunch of extra installs for no reason

## Adding Language Support

You will need to do the following things to add a new language to the editor (and in the case it's me reading this, should be source controlled, so you can use the subset of languages you need whenever):

1. Install the LSP

2. Go to `lsp.lua` and it to the enable list based off whats in their [all configs list](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md). Add in extra configurations there if required

3. Go to `treesitter.lua` and add it to the install command and auto command based off what's in their [supported languages list](https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md)
   
   1. Note, when adding the filetype to the auto command, be careful about what you list. For example, the filetype name for `jsx` is `javascriptreact` and the filetype name for `tsx` is `typescriptreact`. Ironically, the best way to find the right file type name for the language is to look in the lsp all configs list

4. After a restart, you should now be good to go

Note: in the case that there is not language support for your LSP, you can still install the LSP and write the config yourself, it's just more annoying to do

Also, here is a [helpful LSP guide](https://vonheikemen.github.io/devlog/tools/neovim-lsp-client-guide/) that explains how to use everything out of the box

## Future Plugins in Consideration

This list consolidates plugins that look interesting to me that may one day make the cut. I mention them throughout the README, but this lists them in one place so I can look at all the prime contenders

* [seblyng/roslyn.nvim](https://github.com/seblyng/roslyn.nvim) - better .NET support if needed. Depends how happy I am with the current .NET support

* [Kurren123/mssql.nvim](https://github.com/Kurren123/mssql.nvim) - for more specific SQL server support if needed, but I'm not sure how much DB development I'll do in neovim, and this isn't the best supported plugin

* [kndndrj/nvim-dbee](https://github.com/kndndrj/nvim-dbee) - for better db support in neovim. Just like the one above, though, how much DB development am I doing in neovim, and how actively is this really maintained?

* Some option for reading LSP diagnostics easier
  
  * [folke/trouble.nvim](https://github.com/folke/trouble.nvim) - pretty nice one I've used before. However, it has nicer integrations with Telescope and fzf-lua. mini pick is not as supported, and that is my main picker. Even so, this would still work well and is nice
  
  * [nvim-mini/mini.extra](https://github.com/nvim-mini/mini.extra) - would add in extra pickers for mini pick. This would give tree sitter nodes and LSP references, which would be nice

* [nvim-mini/mini.ai](https://github.com/nvim-mini/mini.ai) - as I get used to normal textobject commands like ib, ab, iB, and aB, this could provide more text object commands that make use of treesitter info to grab everything inside a function for example. This would also be extended by mini.extra

* [nvim-mini/mini.hipatterns](https://github.com/nvim-mini/mini.hipatterns) - a potential way to highlight todo tags, if I need that. Would also get some extension from mini.extra
