class DeeJay < ApplicationRecord
  has_secure_password
  
  has_many :radio_shows
  has_many :songs, -> { distinct }, through: :radio_shows
  has_many :artists, -> { distinct }, through: :songs
  
  validates_presence_of :name, :email, :password_digest
  validates :email, uniqueness: true

  ROLE_ADMINISTRATOR = 1
  
  def is_admin?
    return self[:roles] & ROLE_ADMINISTRATOR
  end
end
