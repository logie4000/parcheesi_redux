class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  def call
    { authorized_user: user }
  end

  private
  attr_reader :headers

  def user
    begin
      @user ||= DeeJay.find(decoded_auth_token[:user_id]) if decoded_auth_token
    rescue ActiveRecord::RecordNotFound => e
      raise(Api::ExceptionHandler::InvalidToken, Message.invalid_token)
    rescue ExceptionHandler::InvalidToken => e
      raise(Api::ExceptionHandler::InvalidToken, e.message)
    end
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    end
    Rails.logger.debug("No authorizaton header found")
    raise(Api::ExceptionHandler::MissingToken, Message.missing_token)
  end
end

