class Post < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  after_create :create_vote, :create_fav, :send_created_post_email

  default_scope { order('rank DESC') }
  scope :visible_to, -> (user) { user ? all : joins(:topic).where('topics.public' => true) }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  def up_votes
    votes.where(value: 1).count
  end

  def down_votes
    votes.where(value: -1).count
  end

  def points
    votes.sum(:value)
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970, 1, 1)) / 1.day.seconds
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end

  private

  def send_created_post_email
    FavoriteMailer.new_post(user, self).deliver_now
  end

  def create_vote
    user.votes.create!(value: 1, post: self)
  end

  def create_fav
    user.favorites.create!(post: self)
  end
end
