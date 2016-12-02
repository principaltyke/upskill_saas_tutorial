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
      
      #send email
      #get fields from form
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      ContactMailer.contact_email(name, email, body).deliver
      
      #flash is the hash cache
      #success here is a key. It's value is set here
      #the page form access this key with <%= flash[:success] %>
      flash[:success] = "Message Sent."
      redirect_to new_contact_path
    else
      flash[:danger] = @contact.errors.full_messages.join(", ")
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