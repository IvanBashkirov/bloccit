class Topic < ApplicationRecord
  has_many :posts
  has_many :posts, dependent: :destroy
end
