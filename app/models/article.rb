class Article < ApplicationRecord
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: {minimum: 5, maximum: 100}
  validates :description, presence: true, length: {minimum: 10, maximum: 500}
end