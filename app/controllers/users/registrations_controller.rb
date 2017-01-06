class Users::RegistrationsController < Devise::RegistrationsController
    #inherit from Devise RegistrationsController
    def create
      super do |resource| #super means inherit the 'create' action, but then extend it
        if params[:plan]
          #is there a parameter called param?
          resource.plan_id = params[:plan]  #resource means user in this case. So take whatever is in the form and set this users plan to be that plan id
          if(resource.plan_id == 2)  #so if the form is coming from the pro form, then don't just save the user. We also wanyt to keep the plan id. run the function that we create called save_with_subscription
            resource.save_with_subscription #write a user created function in the model. So in this case models/user.rb
            #the save is done in the model.
          else
            #otherwise just save as normal devise save
            resource.save
          end
        end
      end
    end
end