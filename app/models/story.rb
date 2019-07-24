class Story < ApplicationRecord
  belongs_to :project
  belongs_to :requester, class_name: 'User'
  belongs_to :owner, class_name: 'User'
  has_many :tasks

  validates :name, presence: true
  validates :points, inclusion: { in: [1, 2, 3, 5, 8, 13] }
  validates :project, presence: true
  validates :requester, presence: true
  validates :owner, presence: true
  with_options unless: :pending? do |it|
    it.validates :started_at, presence: true
  end
  with_options unless: :new_record? do |it|
    it.validate :validate_status_sequence
  end
  with_options if: :accepted? do |it|
    it.validates :finished_at, presence: true
    it.validate :validate_finished_at_date
    it.validate :validate_status_accepted
  end

  extend Enumerize
  enumerize :status, in: [:pending, :started, :delivered, :accepted ], default: :pending, predicates: true, scope: true

  has_paper_trail

  include StoryStatusSequence

  def validate_status_sequence
    unless step_back? || stopped? || step_forward?(1)
      errors.add(:status, "cannot be changed from '#{previous_status}' to '#{current_status}'")
    end
  end

  def validate_finished_at_date
    if finished_at < started_at
      errors.add(:finished_at, "must be greater than started_at")
    end rescue nil
  end

  def validate_status_accepted
    tasks_status = tasks.pluck(:done)
    if tasks_status.include?('pending')
      errors.add(:status, "cannot be 'accepted' because there are tasks pending")
    end
  end

end
