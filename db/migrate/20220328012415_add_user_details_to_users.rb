class AddUserDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.string  :avatar
      t.string  :first_name
      t.string  :last_name
      t.string  :phone_number
      t.string  :profession
      t.date    :date_of_birth
      t.integer :user_type
      t.integer :programming_skill
    end
  end
end
