class Blog < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_one_attached :photo

  searchkick word_start: [:title, :user_email]
  def search_data
    {
      title: title,
      content: content,
      user_email: user.email,
    }
  end
end
