class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.string :image
      t.references :author, null: false, foreign_key: { to_table: 'users' }
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
