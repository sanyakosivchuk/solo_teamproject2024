class Blog < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_one_attached :photo

  searchkick word_start: [:title, :user_email, :category_name]

  def search_data
    {
      title: title,
      user_email: user.email,
      category_name: category.name
    }
  end
end
