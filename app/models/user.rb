class User < ActiveRecord::Base
  has_many :photos
  has_many :courses
  has_many :levels

  attr_accessor :password, :password_confirmation

  validates_presence_of :first_name, :last_name, :email
  validates :password, :presence => true, :length => { :minimum => 6, :maximum => 40}, :confirmation => true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}
  validates_uniqueness_of :email #used as username as well

  def password=(password)
    @password = password
    self.salt = Random.rand.to_s
    newPassword = [salt, password].join
    self.password_digest = Digest::SHA1.hexdigest newPassword
  end
  
  def password_valid?(password)
    newPassword = [self.salt, password].join
    newPassword = Digest::SHA1.hexdigest newPassword
    return (newPassword == self.password_digest)
  end

end
