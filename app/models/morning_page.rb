class MorningPage < ApplicationRecord
  belongs_to :user

  # after_initialize :set_default_body, if: :new_record?

  # Chron will run this 5 past midnight every day to create a fresh start
  def self.chron_reset
    MorningPage.create!(created_at: Date.today, user: current_user, body: "get started")
  end
end
