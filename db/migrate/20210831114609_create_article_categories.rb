class CreateArticleCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :article_categories do |t|
      t.references :category, foreign_key: true
      t.references :article, foreign_key: true
    end
  end
end
