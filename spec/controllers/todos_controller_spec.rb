require 'rails_helper'

RSpec.describe Api::V1::TodosController, type: :controller do

  describe 'GET #index' do
    it 'returns empty array if no todos exist' do
      get :index, format: :json
      expect(parsed_response_body["todos"]).to eq([])
    end

    it 'fetches all todos' do
      2.times { create(:todo) }
      get :index, format: :json

      expect(parsed_response_body["todos"].count).to eq(2)
    end
  end

  describe 'GET #show' do
    it 'fetches single todo record' do
      first = create(:todo)
      todo  = create(:todo)
      get :show, id: todo, format: :json

      expect(parsed_response_body["todo"]["id"]).to eq(todo.id)
    end
  end

  describe 'POST #create' do
    it 'creates a new todo' do
      expect { 
        post :create, 
        todo: { description: "hello" },
        format: :json 
      }.to change(Todo, :count).by(1)
    end

    it 'does not create todo without description' do
      expect {
        post :create,
        todo: { :description => "" },
        format: :json
      }.to_not change(Todo, :count)
    end

    it 'raises error without description' do
      post :create,
      todo: { :description => "" },
      format: :json
      expect(response.status).to eq(422)
      expect(parsed_response_body["errors"]["description"]).to eq(["can't be blank"])
    end
  end

  describe 'PATCH #update' do
    it 'updates a record' do
      todo = create(:todo, description: "work hard")
      patch :update, 
        id: todo, 
        todo: { :description => "work even harder" },
        format: :json
      todo.reload
      expect(todo.description).to eq("work even harder")
    end
  end

  describe 'POST #delete' do
    it 'deletes the specified record' do
      todo = create(:todo)
      expect {
        delete :destroy, id: todo, format: :json
      }.to change(Todo, :count).by(-1)
    end
  end

  private

  def parsed_response_body
    JSON.parse(response.body)
  end
end
