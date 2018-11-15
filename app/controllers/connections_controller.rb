class ConnectionsController < ApplicationController
  # skip_before_action :verify_authenticity_token
  def create
    group = Group.find(params[:group_id])
    connection = group.connections.new(connection_params)
    render json: { status: connection.save }
  end

  # Method to check if a connection is present
  # group_id: id of the group which is under check
  # contact_id: id of the contact which is under check
  def check_info
    connection = Connection.where(group_id: params[:group_id], contact_id: params[:contact_id]).first
    json_details = if connection.present?
      {
        status: true,
        delete_connection_url: connection_path(connection),
        connection_id: connection
      }
    else
      { status: false }
    end
    render json: json_details
  end

  # Method to destroy connection
  def destroy
    connection = Connection.find(params[:id])
    render json: { success:  connection.destroy! }
  end

  # Method to add multiple contacts to a group at once
  # group_id: Group which the user wants to add contacts
  def add_multiple
    group = Group.find(params[:connection][:group_id])
    current_user.contacts.each do |contact|
      contact.connections.create(group_id: params[:connection][:group_id])
    end
  end

  private

  # Method to whitelist the connection params
  def connection_params
    params.require(:connection).permit(:contact_id)
  end
end
