class Project < ApplicationRecord
  belongs_to :manager, class_name: 'User'

  validates :name, presence: true
  validates :manager, presence: true
end
