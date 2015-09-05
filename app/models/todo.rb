class Todo < ActiveRecord::Base
  validates :description, presence: true,
                          length: { maximum: 100 }
end
