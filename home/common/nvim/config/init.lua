-- Core configuration
require("core.utils")
require("core.autocmd")

-- User configuration
utils.requiredir("user")

-- Plugins
require("core.plugins")
