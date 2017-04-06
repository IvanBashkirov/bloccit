class User < ApplicationRecord
  include UsersHelper

  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  before_save lambda { self.email = email.downcase if email.present? },
              lambda { self.name = capitalize_name(name) if name.present? },
              lambda { self.role ||= :member }

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :password, presence: true, length: { minimum: 6 }, if: 'password_digest.nil?'
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }

  has_secure_password

  enum role: [:member, :moderator, :admin]
end
