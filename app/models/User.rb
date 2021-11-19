class User < ApplicationRecord
  include ActionText::Attachable

  before_save :downCaseEmail
  
  has_many :articles, dependent: :destroy
  has_secure_password

  validates :username, presence: true, length: {minimum:3 , maximum:25}, uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum:150}, 
                    uniqueness: { case_sensitive: false },
                    format: {with: VALID_EMAIL_REGEX}
  validates_confirmation_of :password

  def to_trix_content_attachment_partial_path
    to_partial_path
  end
  private
  def downCaseEmail
    self.email = email.downcase
  end
end