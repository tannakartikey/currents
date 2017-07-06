require 'rails_helper'

RSpec.describe User, type: :model  do
  let(:user) { User.new }

  it { should have_many :reports }
  it { should have_many :buzzs }
  it { should have_many(:locations).through(:reports) }
  it { should validate_presence_of :state_waters }

  it { expect(user.approved).to be false }
  it { expect(user.subscription_tier).to eq 'recreational' }
end
