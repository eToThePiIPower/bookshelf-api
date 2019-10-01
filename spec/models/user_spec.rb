require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { should have_many(:books).dependent(:destroy) }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should have_secure_password }
end
