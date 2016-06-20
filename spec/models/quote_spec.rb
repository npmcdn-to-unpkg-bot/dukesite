require 'rails_helper'

RSpec.describe Quote, type: :model do
  it { should have_one(:photo) }
  it { should accept_nested_attributes_for(:photo) }
end
