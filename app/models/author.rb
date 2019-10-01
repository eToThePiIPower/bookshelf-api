# Author: The author of a (or many) book(s)
class Author < ApplicationRecord
  validates :name, presence: true
end
