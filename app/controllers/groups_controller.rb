class GroupsController < ApplicationController
  def new
    @group = current_user.groups.new
  end

  def create
    @group = current_user.groups.new(group_params)
    if @group.save
      flash[:notice] = I18n.t('groups.alerts.notice')
      redirect_to user_groups_path
    else
      flash.now[:alert] = I18n.t('shared.alert')
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def index
    @groups = User.includes(groups: :contacts).find(current_user.id).groups.order(created_at: :desc)
    @user_contacts = User.includes(:contacts).find(current_user.id).contacts
  end

  def modify_status
    group = current_user.groups.find(params[:id])
    success = group.update_attributes(active: params[:status])
    render json: { success: success, name: group.name }
  end

  private

  # Method to whitelist the group params
  def group_params
    params.require(:group).permit(:name, :description)
  end
end
