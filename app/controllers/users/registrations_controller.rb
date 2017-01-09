class Users::RegistrationsController < Devise::RegistrationsController
    #before and only for the new action go to the select_plan method to check that a plan has been added correctly
    before_action :select_plan, only: :new
    
    #inherit from Devise RegistrationsController
    #so that users signing up with the pro account (plan id2)
    #save with a special Stripe subscription function
    #otherwise devise signs up user as usual
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
    
    private
    #for the user to have a plan
    def select_plan
      unless (params[:plan] == '1' || params[:plan] == '2')
        flash[:notice] = "Please select a membership plan to sign up."
        redirect_to root_url
      end
    end
end