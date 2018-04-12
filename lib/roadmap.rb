module Roadmap

  # get roadmap & checkpoints
  def get_roadmap(chain_id)
    response = self.class.get(("/roadmaps/#{chain_id}"), headers: {
      authorization: @token
    })
    JSON.parse(response.body)
  end
  
  def get_checkpoint(checkpoint_id)
    response = self.class.get(("/checkpoints/#{checkpoint_id}"), headers: {
      authorization: @token
    })
    JSON.parse(response.body)
  end
  
  # get remaining checkpoints
  def get_remaining_checkpoints(chain_id)
    response = self.class.get(("/enrollment_chains/#{chain_id}/checkpoints_remaining_in_section"), 
    headers: {
      authorization: @token
    })
    JSON.parse(response.body)
  end
  
end