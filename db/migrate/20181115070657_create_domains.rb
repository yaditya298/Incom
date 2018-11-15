class CreateDomains < ActiveRecord::Migration[5.1]
  def change
    create_table :domains do |t|
      t.string :domain
      t.boolean :primary
      t.references :added_by, foreign_key: true

      t.timestamps
    end
  end
end
