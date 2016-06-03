require 'rails_helper'

RSpec.describe SiteConfig, type: :model do
  it { should have_one(:photo) }
  it { should have_many(:keywords) }
  it { should accept_nested_attributes_for(:photo) }
end
