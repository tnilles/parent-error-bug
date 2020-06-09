class Page < ApplicationRecord
  belongs_to :book

  validates :rgb, presence: true, on: :color_page
end
