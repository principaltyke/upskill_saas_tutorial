class Contact < ActiveRecord::Base
  #can be left blank by default, but if validation is needed
  #this is where it goes
  validates :name, presence: true
  validates :email, presence: true
  validates :comments, presence: true
end