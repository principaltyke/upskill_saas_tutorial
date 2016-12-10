class ContactsController < ApplicationController
  
  #GET request to / contact-us
  #Show new contact form
  def new
    #everytime the new contact page is opened, a new object is created
    #and assigned to the variable @Contact
    @contact = Contact.new
  end
  
  #POST Request  / contacts
  #save
  def create
    #Mass assignment  of form fields into Contact object
    @contact = Contact.new(contact_params)
    #Save the Contact object into the database
    if @contact.save
      #Store form fields via parameters, into variables
      #send email
      #get fields from form
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      #Plug variables into Contact Mailer
      #email method and send email
      ContactMailer.contact_email(name, email, body).deliver
      
      #flash is the hash cache
      #success here is a key. It's value is set here
      #the page form access this key with <%= flash[:success] %>
      flash[:success] = "Message Sent."
      #Store success message in flash hash
      #and redirect to the new  action
      redirect_to new_contact_path
    else
      #If Contact object doesn't save,
      #store errors in flash has and redirect 
      #to the new action
      flash[:danger] = @contact.errors.full_messages.join(", ")
      #redirect_to new_contact_path, notice: "Error occurred."
      #when an error occurs @contacts will have accesss to .errors. errors are in an array
      #we split and join each error with a comma and space
      redirect_to new_contact_path
    end
  end
  
  private
    #To collect data from form we need to use strong parameters
    #and whitelist the form fields
    def contact_params
      #the below added to ensure security on the form fileds is maintained
      params.require(:contact).permit(:name, :email, :comments)
    end
end