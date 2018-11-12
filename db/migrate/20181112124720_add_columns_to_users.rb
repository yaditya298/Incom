class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :aadhar_number
    end
  end
end
