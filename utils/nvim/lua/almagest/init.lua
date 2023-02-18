require("almagest.packer")
require("almagest.set")


local present, _ = pcall(require, "which-key")
if present then
    require("almagest.remap")
end
