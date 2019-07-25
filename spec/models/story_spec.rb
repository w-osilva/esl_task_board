require 'rails_helper'

RSpec.describe Story, type: :model do
  describe "associations" do
    it { should have_many(:tasks) }
    it { should belong_to(:project) }
    it { should belong_to(:requester) }
    it { should belong_to(:owner) }
  end

  describe "attributes" do
    let(:attributes) { build(:story).attributes.symbolize_keys }
    it { expect(attributes).to include(:id, :name, :status, :description, :started_at, :finished_at,
                                       :deadline, :points, :requester_id, :owner_id ) }
  end

  describe "enumerize list" do
    it { expect(Story.status.values).to include(:pending, :started, :delivered, :accepted) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_inclusion_of(:points).in_array([nil, 1, 2, 3, 5, 8, 13]) }
    it { should validate_presence_of(:requester) }

    context "with_options" do
      describe "unless: :pending?" do
        before { allow(subject).to receive(:pending?).and_return(false) }
        it { should validate_presence_of(:started_at) }
      end

      describe "unless: :new_record?" do
        it "should validate with 'validate_status_sequence'"
      end

      describe "if: :accepted?" do
        before{ allow(subject).to receive(:accepted?).and_return(true) }
        it { should validate_presence_of(:finished_at) }

        it "should validate with 'validate_finished_at_date'"

        it "should validate with 'validate_status_accepted'"
      end
    end

    context "custom methods" do
      describe "#validate_status_sequence" do
        it "cannot advance status out of sequence" do
          story = create(:story, :pending)
          story.status = :started
          expect(story).to be_valid

          story.status = :delivered
          expect(story).to_not be_valid

          story.status = :accepted
          expect(story).to_not be_valid
        end

        it "can forward status out of sequence" do
          story = create(:story, status: :accepted)
          story.status = :pending
          expect(story).to be_valid
        end
      end

      describe "#validate_finished_at_date" do
        it "cannot end on a date shorter than the one started" do
          story = create(:story, :delivered, finished_at: nil)
          story.status = :accepted
          story.finished_at = story.started_at - 1.minute
          expect(story).to_not be_valid
        end
      end

      describe "#validate_status_accepted" do
        it "should only allow you to advance a story to 'done' if all tasks are marked as finished" do
          story = create(:story, :delivered, finished_at: nil)
          story.tasks << build(:task, :done, story: story)
          story.tasks << build(:task, :pending, story: story)
          story.status = :accepted
          expect(story).to_not be_valid
        end
      end
    end
  end
end
