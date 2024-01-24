curl -i -X POST \
  --url http://localhost:8001/plugins/ \
  --data "name=thirdlaw" \
  --data "config.redirect_url=http://127.0.0.1" \
  --data "config.enable_debug=true"

curl -i -X POST \
  --url http://localhost:8001/services/ \
  --data 'name=example-moesif-service' \
  --data 'url=http://httpbin.org/uuid'

curl -i -X POST \
  --url http://localhost:8001/services/example-moesif-service/routes \
  --data 'hosts[]=test.com'

  curl -i -X GET \
  --url http://localhost:80/ \
  --header 'Host: test.com'