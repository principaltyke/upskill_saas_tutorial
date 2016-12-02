class ContactMailer < ActionMailer::Base
    default to: 'kdspeight@hotmail.co.uk'
    
    def contact_email(name, email, body)
      @name = name
      @email = email
      @body = body
      
      mail(from: email, subject: 'Contact Form Message')
    end
end