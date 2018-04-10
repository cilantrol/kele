require 'rubygems' if RUBY_VERSION < '1.9'
require 'rest_client'

values = '{
  "email": "antblessing@gmail.com",
  "password": "password"
}'

headers = {
  :content_type => 'application/json'
}

response = RestClient.post 'https://www.bloc.io/api/v1/sessions?email=&password=', values, headers
puts response


{
    "auth_token":"eyJ0eXAiOiJKV1QiLCJhhGciOiJIUzI1NiJ9.eyJhcGlfa2V5IjoiYTc2MDZkNTBhYjA3NDE4ZWE4ZmU5NzliY2YxNTM1ZjAiLCJ1c2VyX2lkIjoyMzAzMTExLCJuYW1lIjoiQmVuIE5lZWx5In0.3VXD-FxOoxaGXHu6vmL8g191bl5F_oKe9qj8Khmp9F0",
    "user":
        {
            "id":2307245,
            "email:"antblessing@gmail.com",
            "created_at":"2015-08-11T16:31:08.836-07:00",
            "updated_at":"2015-11-04T13:13:32.457-08:00",
            "facebook_id":null,
            ...,
            "gender":null
        }
}