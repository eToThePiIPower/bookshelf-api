# Book: A book
class Book < ApplicationRecord
  belongs_to :author
  belongs_to :user

  validates :title,
            presence: true
end
