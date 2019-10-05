# Author: The author of a (or many) book(s)
class Author < ApplicationRecord
  has_many :books

  validates :name, presence: true
end
