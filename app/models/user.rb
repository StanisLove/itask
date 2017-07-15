class User < ActiveRecord::Base
  has_many :tasks, dependent: :destroy

  has_secure_password

  before_validation :normalize_email

  validates :email, :password, presence: true
  validates :email, email: true, uniq_email: true
  validates :role, inclusion: { in: 0..1 }
  validates :password, length: { minimum: 6 }, confirmation: true
  validates :name, :last_name, length: { maximum: 60 }

  private

  def normalize_email
    email.downcase! if new_record? && email.present?
  end
end
