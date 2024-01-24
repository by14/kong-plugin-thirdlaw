FROM kong:latest

USER root

# Install the plugin from GitHub
RUN luarocks install https://github.com/username/kong-plugin-thirdlaw/kong-plugin-thirdlaw-1.0-1.rockspec

USER kong
