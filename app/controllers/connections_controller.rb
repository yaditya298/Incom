class ConnectionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    group = Group.find(params[:group_id])
    connection = group.connections.new(connection_params)
    render json: { status: connection.save }
  end

  def destroy
    connection = Connection.find(params[:id])
    render json: { success:  connection.destroy! }
  end

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

  private

  def connection_params
    params.require(:connection).permit(:contact_id)
  end
end
