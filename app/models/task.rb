class Task < ActiveRecord::Base
  include AASM

  belongs_to :user

  has_many :attachments, as: :attachable, dependent: :destroy

  validates :name, presence: true, length: { maximum: 60 }

  accepts_nested_attributes_for :attachments, allow_destroy: true,
    reject_if: proc { |a| a['file'].blank? }

  enum state: {
    fresh: 0,
    started: 1,
    finished: 2
  }

  aasm column: :state do
    state :fresh, initial: true
    state :started
    state :finished

    event :start do
      transitions from: :fresh, to: :started
    end

    event :finish do
      transitions from: :started, to: :finished
    end

    event :restart do
      transitions from: :finished, to: :started
    end
  end

  def switch!
    case state
    when 'fresh'
      start!
    when 'started'
      finish!
    when 'finished'
      restart!
    end
  end
end
