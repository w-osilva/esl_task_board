require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "associations" do
    it { should belong_to(:manager) }
    it { should have_many(:stories) }
  end

  describe "attributes" do
    let(:attributes) { build(:project).attributes.symbolize_keys }
    it { expect(attributes).to include(:id, :name, :manager_id) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:manager) }
  end
end
