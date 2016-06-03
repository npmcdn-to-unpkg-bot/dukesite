require 'rails_helper'

RSpec.describe Showcase, type: :model do
  it { should have_many(:product_showcases) }
  it { should have_many(:products) }
  it { should have_many(:keywords) }
  it { should have_one(:photo) }
  it { should accept_nested_attributes_for(:photo) }
end
