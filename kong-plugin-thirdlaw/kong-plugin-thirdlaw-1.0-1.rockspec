package = "kong-plugin-thirdlaw"
version = "1.0-1"
source = {
    url = "file://."
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
        ["kong.plugins.thirdlaw.handler"] = "path/to/handler.lua",
        ["kong.plugins.thirdlaw.schema"] = "path/to/schema.lua"
    }
}