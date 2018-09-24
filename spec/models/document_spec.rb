require 'rails_helper'

RSpec.describe Document, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:created_by) }
end
