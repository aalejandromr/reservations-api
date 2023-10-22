class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  
  before_action :set_agent
  before_action :authorize_request!

  # Next steps: Create postman documentation, tests endpoint
  attr_reader :agent

  private

  def authorize_request!
    return head :unauthorized unless agent_exists?
  end

  def agent_exists?
    return true if agent
  end

  def set_agent
    @agent = Agent.find_by(agent_code: params[:agent_code])
  end
end
