class Post < ApplicationRecord
  belongs_to :user
  belongs_to :blog

  searchkick

  validates :content, presence: true, length: { minimum: 15 }
  
  def search_data
    {
      content: content,
      blog_title: blog.title
    }
  end
end
