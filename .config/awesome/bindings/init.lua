-- awesome/bindings/init.lua

return {
   client = {
      key = require'bindings.client.key',
      mouse = require'bindings.client.mouse',
   },
   global = {
      key = require'bindings.global.key',
      mouse = require'bindings.global.mouse',
   },
   mod = {
      alt   = "Mod1",
      super = "Mod4",
      shift = "Shift",
      ctrl  = "Control",
   },
}
