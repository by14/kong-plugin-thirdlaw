local typedefs = require "kong.db.schema.typedefs"

return {
    name = "thirdlaw",
    fields = {
        {
          consumer = typedefs.no_consumer
        },
        { config = {
            type = "record",
            fields = {
                { redirect_url = { type = "string", required = true } },
                { enable_debug = { type = "boolean", default = false } },
                { enable_openai_redirect = { type = "boolean", default = false } },
                { enable_gemini_redirect = { type = "boolean", default = false } },
            },
        }},
    },
}