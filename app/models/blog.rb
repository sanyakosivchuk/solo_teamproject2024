class Blog < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_one_attached :photo

  searchkick
  def search_data
    {
      title: title,
      content: content,
    }
  end
end
