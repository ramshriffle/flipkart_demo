# frozen_string_literal: true

module GenerateToken
  include JsonWebToken

  def generate_token(user)
    jwt_encode(user_id: user.id)
  end
end
