package = "kong-plugin-thirdlaw"
version = "1.0-1"
source = {
    url = "git://github.com/by14/kong-plugin-thirdlaw.git"
}
description = {
    summary = "A Kong plugin to redirect requests based on specific conditions.",
    homepage = "http://github.com/yourusername/kong-plugin-thirdlaw",
    license = "Apache 2.0"
}
dependencies = {
    "lua >= 5.1",
    -- Add other dependencies here
}
build = {
    type = "builtin",
    modules = {
        ["kong.plugins.thirdlaw.handler"] = "kong/plugins/thirdlaw/handler.lua",
        ["kong.plugins.thirdlaw.schema"] = "kong/plugins/thirdlaw/schema.lua"
    }
}