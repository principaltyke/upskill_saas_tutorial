class Plan < ActiveRecord::Base
  #each Plan can have many users
  has_many :users
end