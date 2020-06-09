class Book < ApplicationRecord
  has_many :pages

  validate on: :review do
    # some validation, does not matter what
  end

  validate on: :publish do
    pages.each do |page|
      next if page.valid?(:color_page)
      errors.add(:base, 'some pages are not valid!')
    end
  end
end
