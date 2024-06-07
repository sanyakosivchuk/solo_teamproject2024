class Blog < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy

  searchkick
  def search_data
    {
      title: title,
      content: content,
    }
  end
end
