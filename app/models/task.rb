class Task < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true, length: { maximum: 60 }
  validates :state, inclusion: { in: 0..2 }
end
