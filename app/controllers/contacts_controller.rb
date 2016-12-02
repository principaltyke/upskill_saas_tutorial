class ContactsController < ApplicationController
  def new
    #everytime the new contact page is opened, a new object is created
    #and assigned to the variable @Contact
    @contact = Contact.new
  end
  
  #save
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:success] = "Message Sent."
      redirect_to new_contact_path
    else
      flash[:error] = @contact.errors.full_messages.join(", ")
      #redirect_to new_contact_path, notice: "Error occurred."
      #when an error occurs @contacts will have accesss to .errors. errors are in an array
      #we split and join each error with a comma and space
      redirect_to new_contact_path
    end
  end
  
  private
    def contact_params
      #the below added to ensure security on the form fileds is maintained
      params.require(:contact).permit(:name, :email, :comments)
    end
end