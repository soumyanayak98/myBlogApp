class Comment < ApplicationRecord
  has_rich_text :body
  belongs_to :article
end
