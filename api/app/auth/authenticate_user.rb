class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end


  def call
    JsonWebToken.encode(user_id: user.id) if (user)
  end


  private
  attr_reader :email, :password

  def user
    this_user = DeeJay.find_by(email: email)
    return this_user if this_user && this_user.authenticate(password)

    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end

