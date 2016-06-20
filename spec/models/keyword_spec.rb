require 'rails_helper'

RSpec.describe Keyword, type: :model do
  it { should belong_to(:keywordable) }
end
