FROM kong:latest

USER root

# Install the plugin from GitHub
RUN luarocks install https://raw.githubusercontent.com/by14/kong-plugin-thirdlaw/main/kong-plugin-thirdlaw/kong-plugin-thirdlaw-1.0-1.rockspec

USER kong