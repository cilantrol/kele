require 'httparty'
require 'pp'
require 'json'
require './lib/roadmap.rb'
require './lib/secrets.rb'

include Secrets

  class Kele
    include HTTParty
    include Roadmap

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
        authorization: @token
      })
      JSON.parse(response.body)
    end
    
    # get mentor available time slots
    def get_mentor_availability(mentor_id)
      response = self.class.get(("/mentors/#{mentor_id}/student_availability"), headers:{
        authorization: @token
      })
      JSON.parse(response.body)
    end
    
    # get messages
    def get_messages(message_id = nil)
      if message_id == nil
        response = self.class.get(("/message_threads"), headers: {
          authorization: @token
        })
      else
        response = self.class.get(("/message_threads?page=#{message_id}"), headers:{
          authorization: @token
        })
      end
      JSON.parse(response.body)
    end
    
    # create messages
    def create_message(email, receiver_id, token, subject, message)
      response = self.class.post(("/messages"),
        values:  {
                      'sender':         email,
                      'recipient_id':   receiver_id,
                      'token':          token,
                      'subject':        subject,
                      'stripped-text':  message},
                      
        headers: {    authorization:    @token})
    end
    
  end

  # Usage Example
  # using pp will default in JSON
  party = Kele.new($user_email, $user_password)
  party.tokens
  p party.get_messages
  # p party.create_message('gaowhui@gmail.com', 2, 'token?', 'asdasdfasdf', 'body of message')
