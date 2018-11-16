class AddConnectionCountToGroups < ActiveRecord::Migration[5.1]
  def self.up
    add_column :groups, :connections_count, :integer, default: 0
    Group.reset_column_information
    Group.all.each do |group|
      Group.update_counters group.id, connections_count: group.connections.length
    end
  end

  def self.down
    remove_column :groups, :connections_count
  end
end
