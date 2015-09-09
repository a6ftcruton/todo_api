class TodoSerializer < ActiveModel::Serializer
  attributes :id, :id, :description, :complete, :updated_at
end
