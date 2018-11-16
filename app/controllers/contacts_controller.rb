class ContactsController < ApplicationController

  # Build a new contact for a user with particular :user_id
  def new
    @contact = current_user.contacts.new
  end

  # Creates a contact for a user
  def create
    @contact = current_user.contacts.create(contact_params)
    if @contact.save
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
    params.require(:contact).permit(:name, :email, :mobile, :address)
  end
end
