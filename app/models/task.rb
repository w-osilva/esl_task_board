class Task < ApplicationRecord
  belongs_to :story

  validates :description, presence: true

  extend Enumerize
  enumerize :done, in: {:pending => 0, :done => 1}, default: :pending, predicates: true, scope: true
end
