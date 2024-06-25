class Post < ApplicationRecord
  belongs_to :blog
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :content, presence: true, length: { minimum: 15 }
end
