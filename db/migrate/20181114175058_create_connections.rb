class CreateConnections < ActiveRecord::Migration[5.1]
  def change
    create_table :connections do |t|
      t.references :contact, foreign_key: true
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
