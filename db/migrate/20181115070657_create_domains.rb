class CreateDomains < ActiveRecord::Migration[5.1]
  def change
    create_table :domains do |t|
      t.string :domain
      t.boolean :primary
      t.integer :added_by_id, foreign_key: true
      t.integer :updater_id

      t.timestamps
    end
  end
end
