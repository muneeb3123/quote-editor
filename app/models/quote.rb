class Quote < ApplicationRecord
    # after_create_commit -> { broadcast_prepend_later_to "quotes" }
    # after_update_commit -> { broadcast_replace_later_to "quotes" } 
    # after_destroy_commit -> { broadcast_remove_to "quotes" }
    belongs_to :company
    has_many :line_item_dates, dependent: :destroy

    broadcasts_to ->(quote) { [ quote.company, "quotes" ] }, inserts_by: :prepend # this is equal to above three line

    validates :name, presence: true
    scope :ordered, -> { order(id: :desc) }

  end