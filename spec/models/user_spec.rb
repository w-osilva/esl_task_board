require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:projects) }
    it { should have_many(:stories_as_requester).with_foreign_key('requester_id').class_name('Story') }
    it { should have_many(:stories_as_owner).with_foreign_key('owner_id').class_name('Story') }
  end

  describe "attributes" do
    let(:attributes) { build(:user).attributes.symbolize_keys }
    it { expect(attributes).to include(:id, :name, :email, :role) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end
