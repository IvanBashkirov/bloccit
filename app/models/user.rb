class User < ApplicationRecord

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  before_save -> { self.email = email.downcase if email.present? },
              -> { self.name = capitalize_name(name) if name.present? },
              -> { self.role ||= :member }

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :password, presence: true, length: { minimum: 6 }, if: 'password_digest.nil?'
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }

  has_secure_password

  def capitalize_name(name)
    names = name.split(' ')
    names.each {|n| n[0] = n[0].upcase}
    names.join(' ')
  end

  def favorite_for(post)
    favorites.where(post_id: post.id).first
  end

  def avatar_url(size)
    gravatar_id = Digest::MD5.hexdigest(email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

  enum role: [:member, :moderator, :admin]
end
