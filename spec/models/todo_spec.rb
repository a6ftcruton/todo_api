require 'rails_helper'

RSpec.describe Todo, type: :model do

  it 'is valid' do
    todo = build(:todo)
    expect(todo).to be_valid
  end

  it 'is invalid without a description' do
    todo = build(:todo, description: "")
    expect(todo).to_not be_valid
  end

  it 'by default is not marked as complete' do
    todo = build(:todo)
    expect(todo.complete).to eq(false)
  end

  it 'is invalid with a description longer than 100 characters' do
    verbose = "a" * 101
    todo    = build(:todo, description: verbose)

    expect(todo).to_not be_valid
  end

end
