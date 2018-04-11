require 'httparty'
require 'pp'
require 'json'

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
    
    # get user info
    def get_me
      response = self.class.get(('/users/me'), headers: {
        # "authorization" => @token 
        authorization: @token
      })
      # response.body => parse to JSON
      JSON.parse(response.body)
    end
    
    # get mentor available time slots
    def get_mentor_availability(mentor_id)
      response = self.class.get(("/mentors/#{mentor_id}/student_availability"), headers:{
        authorization: @token
      })
      # response.body => parse to JSON
      JSON.parse(response.body)
    end
    
  end
  
  # Usage Example
  # using pp will default in JSON
  # party = Kele.new('asdf', 'asdf')
  party.tokens
  # p party.get_me
  mentor_id = 10
  p party.get_mentor_availability(mentor_id)