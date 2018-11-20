class ContactsController < ApplicationController

  # Build a new contact for a user with particular :user_id
  def new
    @contact = current_user.contacts.new
  end

  # Creates a contact for a user
  def create
    @contact = current_user.contacts.create(contact_params)
    if @contact.save
      if params[:group_id]
        group = Group.find(params[:group_id])
        @contact.connections.create(group_id: params[:group_id])
        flash[:notice] = I18n.t('contacts.alerts.added_to_group', name: group.name)
        redirect_to user_groups_path(current_user) and return
      end
      flash[:notice] = I18n.t('contacts.alerts.notice')
      redirect_to user_contacts_path(current_user)
    else
      flash.now[:alert] = I18n.t('shared.alert')
      render :new
    end
  end

  def edit
    @contact = current_user.contacts.find(params[:id])
  end

  def update
    @contact = current_user.contacts.find(params[:id])
    if @contact.update_attributes(contact_params)
      flash[:notice] = I18n.t('contacts.alerts.update_notice')
      redirect_to user_contacts_path(current_user)
    else
      flash.now[:alert] = I18n.t('shared.alert')
      render :edit
    end
  end

  def show
    @contact = Contact.find(params[:id])
  end

  # List the contacts for a particular user with :user_id
  def index
    @contacts = current_user.contacts
  end

  private

  # Method to whitelist the contact params
  def contact_params
    params.require(:contact).permit(:name, :email, :mobile, :address, :group_id, :project, :role)
  end
end
