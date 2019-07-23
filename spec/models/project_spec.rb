require 'rails_helper'

RSpec.describe Project, type: :model do
  it "validate assossiations" do
    should belong_to(:manager)
  end

  context "attributes" do
    let(:attributes) { build(:project).attributes.symbolize_keys }
    it { expect(attributes).to include(:id, :name, :manager_id) }
  end
end
