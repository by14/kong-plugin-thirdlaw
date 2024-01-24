FROM kong:latest

USER root

# Copy the entire plugin directory to the container
COPY kong-plugin-thirdlaw /usr/local/share/lua/5.1/kong/plugins/thirdlaw

# Install the plugin using its .rockspec file
RUN luarocks install /usr/local/share/lua/5.1/kong/plugins/thirdlaw/kong-plugin-thirdlaw-1.0-1.rockspec

USER kong