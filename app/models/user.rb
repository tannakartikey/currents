class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable, :confirmable
  validates :state_waters, presence: true
	has_many :reports
	has_many :buzzs   
	has_many :locations, through: :reports
  belongs_to :state, primary_key: :name, foreign_key: :state_waters
  after_create :create_stripe_customer
  before_destroy :delete_stripe_customer

  #display_name is defined for activeadmin
	def display_name
		self.email
	end

  def create_stripe_customer
    unless Rails.env.test?
      StripeCustomer.create(self)
      if Rails.env.development?
        StripeSubscription.create(self, DateTime.now.to_i + 300 )
      else
        StripeSubscription.create(self, (Date.today + 31).to_time.to_i )
      end
    end
  end

  def delete_stripe_customer
    StripeCustomer.delete(self)
  end

  def trial_over?
    if self.subscription_id?
      StripeCustomer.retrieve(self).subscriptions.data[0].status == 'trialing' ? false : true
    else
      true
    end
  end

  def remaining_trial_days
    trial_end_timestamp = StripeCustomer.retrieve(self).subscriptions.data.first.trial_end.to_s
    ((DateTime.strptime(trial_end_timestamp, '%s').to_date) - Date.today).to_i
  end

  def has_active_subscription?
    self.subscription_id? && self.is_active?
  end
end
