package = "nfnl"
version = "dev-1"
source = {
   url = "git+ssh://git@github.com/k13labs/nfnl.git"
}
description = {
   summary = "Enhance your [Neovim][neovim] experience through [Fennel][fennel] with zero overhead.",
   detailed = [[
Enhance your [Neovim][neovim] experience through [Fennel][fennel] with zero
overhead. Write Fennel, run Lua, nfnl will not load unless you're actively
modifying your Neovim configuration or plugin source code
([nfnl-plugin-example][nfnl-plugin-example]).]],
   homepage = "*** please enter a project homepage ***",
   license = "*** please specify a license ***"
}
build = {
   type = "builtin",
   modules = {
      ["nfnl.api"] = "lua/nfnl/api.lua",
      ["nfnl.autoload"] = "lua/nfnl/autoload.lua",
      ["nfnl.callback"] = "lua/nfnl/callback.lua",
      ["nfnl.compile"] = "lua/nfnl/compile.lua",
      ["nfnl.config"] = "lua/nfnl/config.lua",
      ["nfnl.core"] = "lua/nfnl/core.lua",
      ["nfnl.fennel"] = "lua/nfnl/fennel.lua",
      ["nfnl.fs"] = "lua/nfnl/fs.lua",
      ["nfnl.init"] = "lua/nfnl/init.lua",
      ["nfnl.module"] = "lua/nfnl/module.lua",
      ["nfnl.notify"] = "lua/nfnl/notify.lua",
      ["nfnl.nvim"] = "lua/nfnl/nvim.lua",
      ["nfnl.string"] = "lua/nfnl/string.lua"
   },
   copy_directories = {
      "docs"
   }
}
