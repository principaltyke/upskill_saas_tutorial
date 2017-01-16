class Profile < ActiveRecord::Base
    #each profile will belong to a user and each user has one profile
    belongs_to :user 
end