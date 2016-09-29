class TasksController < ApplicationController
  def index
    @welcome_msg = "Hello!! Welcome to Tasks Master! Here are your tasks: (Do them or DIE)"
    @tasks = Task.all
  end

  def show
    @onetask = Task.find(params[:id].to_i)
  end

  def new
    @onetask = Task.new
  end

  def edit
    show
  end

  def update
    show

    @onetask[:title] = params["title"]
    @onetask[:description] = params["description"]
    @onetask[:status] = params["status"]
    @onetask[:status] == "yes" ? @onetask[:completed] = Date.new : @onetask[:completed] = nil
  end


  def destroy
    @onetask = Task.destroy(params[:id].to_i)
  end

  def create
    @params = params
    @onetask = Task.new

    @title = params[:task][:title]
    @description = params[:task][:description]
    @completed = [:task][:completed]

    @onetask.save
  end

  def self.alltasks
    [
      {id: 1, title: "Groceries", description: "Go buy eggs, milk, cheese, yogurt, icecream, half and half, and any other dairy product you can think of", status: "no", completed: nil},
      {id: 2, title: "Workout", description: "Get your heart a pumpin!", status: "yes", completed: Date.new},
      {id: 3, title: "Homework", description: "Time to get smart!", status: "no", completed: nil}
    ]
  end



end
