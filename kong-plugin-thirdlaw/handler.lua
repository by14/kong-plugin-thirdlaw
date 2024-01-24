local BasePlugin = require "kong.plugins.base_plugin"
local ThirdlawHandler = BasePlugin:extend()

function ThirdlawHandler:new()
    ThirdlawHandler.super.new(self, "thirdlaw")
end

function ThirdlawHandler:access(conf)
    ThirdlawHandler.super.access(self)

    local request_path = kong.request.get_path()
    local request_host = kong.request.get_host()

    if conf.enable_debug then
        kong.log.debug("Request path: ", request_path)
        kong.log.debug("Request host: ", request_host)
        kong.log.debug("Redirect URL from config: ", conf.redirect_url)
    end

    if shouldRedirect(request_host, request_path, conf) then
        local target_url = conf.redirect_url .. request_path
        if conf.enable_debug then
            kong.log.debug("Redirecting to: ", target_url)
        end
        return kong.response.exit(301, {}, {["Location"] = target_url})
    end
end

function shouldRedirect(host, path, conf)
    if conf.enable_openai_redirect and host:find("api.openai.com") then
        if conf.enable_debug then
            kong.log.debug("Redirecting due to OpenAI API host match")
        end
        return true
    end

    if
        conf.enable_gemini_redirect and
            path:match("^/v1/projects/.+/locations/.+/publishers/google/models/gemini%-pro:streamGenerateContent$")
     then
        if conf.enable_debug then
            kong.log.debug("Redirecting due to Google API path match")
        end
        return true
    end

    if conf.enable_debug then
        kong.log.debug("No redirect conditions met")
    end

    return false
end

return ThirdlawHandler
