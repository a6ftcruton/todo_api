module Api
  module V1
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
        #TODO create custom responder for api (since not redirecting)
        #http://stackoverflow.com/questions/23582389/rails-nomethoderror-undefined-method-url-for-controller-i-cant-seem-to-res
        respond_with :api, :v1, @todo
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

  end
end
