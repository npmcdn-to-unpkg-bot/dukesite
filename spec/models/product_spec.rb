require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should callback(:generate_slug).after(:validation) }

  it { should have_many(:product_categories) }
  it { should have_many(:categories) }
  it { should have_many(:product_showcases) }
  it { should have_many(:showcases) }
  it { should have_many(:keywords) }
end
