require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should have_many(:product_categories) }
  it { should have_many(:products) }
  it { should have_many(:keywords) }
  it { should have_one(:photo) }
  it { should accept_nested_attributes_for(:photo) }
end
