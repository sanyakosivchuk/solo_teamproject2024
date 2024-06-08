class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :blogs
  has_many :posts

  enum role: { default: 'default', admin: 'admin' }

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :default
  end
end
