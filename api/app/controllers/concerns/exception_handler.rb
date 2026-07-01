module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class NotAuthorized < StandardError; end

  included do
    rescue_from ActiveRecord::RecordNotUnique, with: :four_twenty_two
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :unauthorized_request
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ExceptionHandler::NotAuthorized, with: :unauthorized_request

    rescue_from ActiveRecord::RecordNotFound do |e|
      respond_to do |format|
        format.html { html_response({ message: e.message }, status: :not_found) }
        format.json { json_response({ message: e.message }, status: :not_found) }
      end
    end
  end

  private
  def four_twenty_two(e)
    respond_to do |format|
      format.html {
        flash[:notice] = "Your request cannot be processed"
      } 
      format.json { json_response({ message: e.message }, status: :unprocessable_entity) }
    end
  end

  def unauthorized_request(e)
    respond_to do |format|
      format.html { 
        flash[:notice] = "Unauthorized request. Please log in"
        redirect_to login_path #, status: :unauthorized 
      }
      format.json { json_response({ message: e.message }, status: :unauthorized) }
    end
  end
end

