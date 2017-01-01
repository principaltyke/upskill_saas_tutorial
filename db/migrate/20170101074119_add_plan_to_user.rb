class AddPlanToUser < ActiveRecord::Migration[5.0]
  def change
    #create primary and foreign key
    add_column :users, :plan_id, :integer
  end
end
