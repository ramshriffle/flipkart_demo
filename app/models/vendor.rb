# frozen_string_literal: true

# vendor class
class Vendor < User
  has_many :products, foreign_key: 'user_id', dependent: :destroy
end
