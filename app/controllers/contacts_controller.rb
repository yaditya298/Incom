class ContactsController < ApplicationController

  # Build a new contact for a user with particular :user_id
  def new
    @contact = current_user.contacts.new
  end

  # Creates a contact for a user
  def create
    @contact = current_user.contacts.create(contact_params)
    if @contact.save
      redirect_to user_contact_path(current_user, @contact)
    else
      render :new
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
