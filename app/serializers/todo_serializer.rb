class TodoSerializer < ActiveModel::Serializer
  attributes :id, :description, :complete, :created_at, :updated_at
end
