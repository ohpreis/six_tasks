class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { minimum: 3 }
  validates :status, presence: true
  enum :status, [ :doing, :backlog, :idea, :done ]

  after_initialize :set_default_status, if: :new_record?

  def set_default_status
    self.status ||= :backlog
  end

  def self.chron_reset
    Task.where(status: :doing).update_all(status: :backlog)
  end
end
