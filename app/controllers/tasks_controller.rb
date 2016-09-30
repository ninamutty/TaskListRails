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
    @onetask = Task.find(params[:id].to_i)
  end

  def update
    @params = params

    @onetask = Task.find(params[:id].to_i)

    @onetask.title = params[:task][:title]
    @onetask.description = params[:task][:description]
    @onetask.complete = params[:task][:complete]
    @onetask.completed_at = DateTime.now if @onetask.complete == true

    @onetask.save
    redirect_to action: 'index'
  end

  def complete
    @onetask = Task.find(params[:id].to_i)
    
    @onetask.complete = true
    @onetask.completed_at = DateTime.now if @onetask.complete == true
    @onetask.save

    redirect_to action: 'index'
  end

  def destroy
    @onetask = Task.destroy(params[:id].to_i)
    redirect_to action: 'index'
  end

  def create
    @params = params
    @onetask = Task.new

    @onetask.title = params[:task][:title]
    @onetask.description = params[:task][:description]
    @onetask.complete = params[:task][:complete]
    @onetask.completed_at = DateTime.now if @onetask.complete == true

    @onetask.save
    redirect_to action: 'index'
  end

  def self.alltasks
    [
      {id: 1, title: "Groceries", description: "Go buy eggs, milk, cheese, yogurt, icecream, half and half, and any other dairy product you can think of", status: "no", completed: nil},
      {id: 2, title: "Workout", description: "Get your heart a pumpin!", status: "yes", completed: Date.new},
      {id: 3, title: "Homework", description: "Time to get smart!", status: "no", completed: nil}
    ]
  end



end
