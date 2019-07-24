require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "associations" do
    it { should belong_to(:story) }
  end

  describe "attributes" do
    let(:attributes) { build(:task).attributes.symbolize_keys }
    it { expect(attributes).to include(:id, :description, :done ) }
  end

  describe "validations" do
    it { should validate_presence_of(:description) }
  end
end
