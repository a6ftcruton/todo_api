class TodosController < ApplicationController

  respond_to :json

  def index
    @todos = Todo.all
    respond_with @todos
  end

  def show
    @todo = Todo.find(params[:id])
    respond_with @todo
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.save
    respond_with @todo
  end

  def update
    @todo = Todo.find(params[:id])
    @todo.update(todo_params)
    respond_with @todo
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    respond_with @todo
  end

  private

  def todo_params
    params.require(:todo).permit(:description)
  end
end
