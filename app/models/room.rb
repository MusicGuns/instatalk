class Room < ApplicationRecord
  before_create :generate_token

  has_many :messages
  has_many :onlines

  has_many :users, through: :onlines

  def to_param
    token
  end

  private

  def generate_token
    self.token = SecureRandom.hex(2)
  end
end
