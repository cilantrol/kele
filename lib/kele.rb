require 'httparty'
require 'pp'

  class Kele
    include HTTParty
    base_uri 'https://www.bloc.io/api/v1'
    
    def initialize(email, password)
        @options = { body: {
          email: email,
          password: password
        } }
    end
    
    # get auth token
    def tokens
      response = self.class.post(('/sessions'), @options)
      raise "Error Invalid/Wrong parameters" if response.code == 404 || response['auth_token'].nil?
      @token = response['auth_token']
    end
  end
  
  # Usage Example
  party = Kele.new('email@email', 'password')
  pp party.tokens


