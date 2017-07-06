class AddApprovalFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :approved, :boolean, :default => false, :null => false
    add_column :users, :licence,  :string,  :null => true
    User.find_each do |user|
      user.approved = false
      user.save!
    end
    add_index  :users, :approved
  end
end
