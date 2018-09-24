class Review < ApplicationRecord
  belongs_to :document
  validates_presence_of :comment
end
