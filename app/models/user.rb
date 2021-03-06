class User < ApplicationRecord
  has_many :projects, foreign_key: "manager_id"
  has_many :stories_as_requester, foreign_key: "requester_id", class_name: "Story"
  has_many :stories_as_owner, foreign_key: "owner_id", class_name: "Story"

  validates :name, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  extend Enumerize
  enumerize :role, in: [:admin, :user, :guest], default: :user, predicates: true, scope: true
end
