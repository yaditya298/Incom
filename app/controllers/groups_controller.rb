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
    @groups = current_user.groups.order(created_at: :desc)
    @user_contacts = current_user.contacts
  end

  private

  # Method to whitelist the group params
  def group_params
    params.require(:group).permit(:name, :description)
  end
end
