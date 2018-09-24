class DocumentSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_by, :created_at, :updated_at
  
  has_many :reviews
end