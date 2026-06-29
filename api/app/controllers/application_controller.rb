class ApplicationController < ActionController::API
  #  include ActionController::MimeResponds
  include Response
  include Api::ExceptionHandler

  before_action :authorize_api_request, only: [ :create, :update, :destroy ]
  before_action :add_allow_origin_headers, only: [ :index, :show ]
  attr_reader :current_user

  private
  def authorize_api_request
    Rails.logger.debug("Calling authorize_api_request...")
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:authorized_user]
  end
  
  def add_allow_origin_headers
	  response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
  end
end
