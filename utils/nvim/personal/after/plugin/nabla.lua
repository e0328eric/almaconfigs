local wk = require("which-key")
local nabla = require("nabla")

wk.register({p = {nabla.popup(), "Toogle Math Symbol"}}, {prefix = "<leader>"})
