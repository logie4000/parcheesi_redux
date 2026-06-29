module ControllerSpecHelper
  # generate tokens from user id
  def token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  # generate expired tokens from user id
  def expired_token_generator(user_id)
    JsonWebToken.encode( {user_id: user_id}, (Time.now.to_i - 10) )
  end

  # return valid headers
  def valid_headers
    {
      "Authorization" => token_generator(user.id),
      "Content-type" => "application/json",
      "Accept" => "application/json",
    }
  end

  def valid_html_headers
    {
      "Authorization" => token_generator(user.id),
      "Content-type" => "text/html",
      "Accept" => "text/html",
    }
  end

  def invalid_headers
    {
      "Authorization" => nil,
      "Content-type" => "application/json",
    }
  end
end
