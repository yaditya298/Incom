class UsersController < ApplicationController
  before_action :check_admin, only: [:new_admins, :mark_as_admin]

  def new_admins
    @users = User.order(first_name: :desc).all
  end

  # This method is used to make a user admin from the front end
  def mark_as_admin
    @user = User.find(params[:id])
    status = if params[:admin_status] == 'true'
      admin = true
      @user.update_column(:role, 'admin')
    elsif params[:admin_status] == 'false'
      admin = false
      @user.update_column(:role, nil)
    end
    render json: { status: status, name: @user.full_name, admin: admin }
  end

  private

  def check_admin
    unless current_user.admin?
      flash[:alert] = I18n.t('shared.denied')
      redirect_to user_groups_path(current_user)
    end
  end
end
