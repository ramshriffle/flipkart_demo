module GenerateToken
  include JsonWebToken

  def generate_token(user)
    token = jwt_encode(user_id: user.id)
    token
  end
end