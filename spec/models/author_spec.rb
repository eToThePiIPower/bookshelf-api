require 'rails_helper'

RSpec.describe Author, type: :model do
  subject { create(:author) }

  it { should have_many :books }
  it { should validate_presence_of(:name) }
end
