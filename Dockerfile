FROM kong:latest

USER root

# COPY kong-plugin /usr/local/share/lua/5.1/kong/plugins/kong-plugin
COPY kong-plugin-thirdlaw /usr/local/share/lua/5.1/kong/plugins/kong-plugin
RUN luarocks install /usr/local/share/lua/5.1/kong/plugins/kong-plugin/kong-plugin-thirdlaw-1.0-1.rockspec

USER kong