module ConnectionsHelper
  # Method to check if connection with given contact_id, group_id exists.
  def get_checked_value(contact_id, group_id)
    true if Connection.where(contact_id: contact_id, group_id: group_id).present?
  end

  def get_checked_property(group)
    group.connections.size == current_user.contacts.count
  end
end
