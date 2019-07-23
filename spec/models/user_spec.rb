require 'rails_helper'

RSpec.describe User, type: :model do
  it "validate assossiations" do
    should have_many(:projects)
  end

  context "attributes" do
    let(:attributes) { build(:user).attributes.symbolize_keys }
    it { expect(attributes).to include(:id, :name, :email, :role) }
  end
end
