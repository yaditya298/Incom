class AddActiveToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :active, :boolean, default: true
  end
end
