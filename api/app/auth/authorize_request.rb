class AuthorizeRequest
  def initialize(headers = {})
    @headers = headers
  end

  def call
    { user: user }
  end

  private
  attr_reader :headers

  def user
    begin
      @user ||= DeeJay.find(decoded_auth_token[:user_id]) if decoded_auth_token
    rescue ActiveRecord::RecordNotFound => e
      raise(ExceptionHandler::InvalidToken, Message.invalid_token)
    end
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      Rails.logger.debug("Authorization=#{ headers['Authorization'].split(' ').last }")
      return headers['Authorization'].split(' ').last
    end
    Rails.logger.debug("Decoded Authorization not present in request.")
    raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end

