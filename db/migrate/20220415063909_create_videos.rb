class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :image
      t.string :video_link
      t.integer :video_type
      t.references :mentor, null: false, foreign_key: { to_table: 'users' }
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
