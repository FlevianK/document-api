require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should belong_to(:document)}
  it { should validate_presence_of(:comment)}
end
