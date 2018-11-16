class CreateDomains < ActiveRecord::Migration[5.1]
  def self.up
    create_table :domains do |t|
      t.string :name
      t.boolean :current
      t.integer :added_by_id, foreign_key: true
      t.integer :updater_id

      t.timestamps
    end
    Domain.create!(name: Domain::DEFAULT_DOMAIN, current: true)
  end

  def self.down
    drop_table :domains
  end
end
