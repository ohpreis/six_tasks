class MorningPage < ApplicationRecord
  belongs_to :user
  has_rich_text :body # this is for ActionText

  # after_initialize :set_default_body, if: :new_record?
end
