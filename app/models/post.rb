class Post < ApplicationRecord
  belongs_to :user
  belongs_to :blog

  searchkick
  def search_data
    {
      content: content,
      blog_title: blog.title
    }
  end
end
