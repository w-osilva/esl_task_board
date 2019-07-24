class Project < ApplicationRecord
  belongs_to :manager, class_name: 'User'
  has_many :stories

  validates :name, presence: true
  validates :manager, presence: true
end
