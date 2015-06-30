class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: {in: 1..140 }
  validates :user_id, presence: true

  def feed
    Micropost.where("user_id = ?", id)
  end
end
