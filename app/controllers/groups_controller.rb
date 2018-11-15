class GroupsController < ApplicationController
  def new
    @group = current_user.groups.new
  end

  def create
    @group = current_user.groups.new(group_params)
    if @group.save
      redirect_to user_group_path(current_user, @group)
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def index
    @groups = current_user.groups
    @user_contacts = current_user.contacts
  end

  private

  # Method to whitelist the contact params
  def group_params
    params.require(:group).permit(:name, :description)
  end
end
