class ContactsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @contacts = @user.contacts
  end
end
