class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.string :title
      t.text :description
      t.string :image
      t.string :form_link
      t.string :schedule_link
      t.string :learning_tools, array: true, default: []
      t.integer :schedule_type
      t.integer :status
      t.datetime :event_date
      t.references :mentor, null: false, foreign_key: { to_table: 'users' }
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
