require 'rails_helper'

RSpec.describe Article, type: :model do
  it { should have_one(:photo) }
  # it { should validate_presence_of(:title) }
  it { should accept_nested_attributes_for(:photo) }
end
