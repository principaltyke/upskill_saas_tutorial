class User < ApplicationRecord
# Include default devise modules. Others available are:
# :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  #each user should belong to a plan
  belongs_to :plan

  attr_accessor :stripe_card_token  #whitelist theis field so that we can use it below
  def save_with_subscription
    #validate the fields email password password conf
    if valid?
    #if valid, then create a Stripe subscription for ongoing payments. NB if just a one time charge, this is not necessary as we will have received the card toke with the charge as a one off
    #because we are wanting a monthly fee, we need to create a customer at Strip and use the card token to create a subscription
    customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token) #Stripe will charge their card using the token that they gave us and create a subscription. Then call the rails server here and return an object of data. This is assigned to var customer
    #customer_token is the subscription id. That is what we keep
    #customer.id  is the customer_token
    #self is the user. stripe_customer_token is the field in the model and database
    self.stripe_customer_token = customer.id
    #now save the user to the database
    save!
    end
  end
end
