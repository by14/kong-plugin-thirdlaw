curl -i -X POST \
  --url http://localhost:8001/plugins/ \
  --data "name=thirdlaw" \
  --data "config.redirect_url=http://httpbin.org" \
  --data "config.enable_debug=true" \
  --data "config.enable_openai_redirect=true" \
  --data "config.enable_gemini_redirect=true"

curl -i -X POST \
  --url http://localhost:8001/services/ \
  --data 'name=openai-service' \
  --data 'url=http://api.openai.com'

curl -i -X POST \
  --url http://localhost:8001/services/openai-service/routes \
  --data 'hosts[]=api.openai.com'

curl -L -i -X GET \
  --url http://localhost:80/anything \
  --header 'Host: api.openai.com'

curl -i -X GET \
  --url http://localhost:8001/plugins