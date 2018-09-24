class Document < ApplicationRecord
  has_many :reviews, dependent: :destroy
  validates_presence_of :title, :content, :created_by
end
