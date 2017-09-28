class CreatedAtForArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :updated_at, :datetime
  end
end
