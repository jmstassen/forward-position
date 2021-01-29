class User < ActiveRecord::Base
  validates :email, uniqueness: true
  has_secure_password

  has_many :tasks
  has_many :references
  has_many :contacts
end