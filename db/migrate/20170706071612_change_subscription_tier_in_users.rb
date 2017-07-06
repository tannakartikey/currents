class ChangeSubscriptionTierInUsers < ActiveRecord::Migration
  def change
    change_column :users, :subscription_tier, :string, :default => 'recreational', :null => false
    User.find_each do |user|
      user.subscription_tier = 'recreational'
      user.save!
    end
  end
end
