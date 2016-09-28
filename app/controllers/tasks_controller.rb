class TasksController < ApplicationController
  def index
    @welcome_msg = "Hello!! Welcome to Tasks Master! Here are your tasks: (Do them or DIE)"
    @tasks = TasksController.alltasks
  end

  def show
    @tasks = TasksController.alltasks
    @onetask = nil
    @tasks.each do |task|
      number = params[:id].to_i

      if task[:id] == number
        @onetask = task
      end
    end
    if @onetask == nil
      render :file => 'public/404.html', :status => :not_found, :layout => false
    end
  end

  def new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def create
  end

  def self.alltasks
    [
      {id: 1, title: "Groceries", description: "Go buy eggs, milk, cheese, yogurt, icecream, half and half, and any other dairy product you can think of", status: false, completed: nil},
      {id: 2, title: "Workout", description: "Get your heart a pumpin!", status: true, completed: Date.new},
      {id: 3, title: "Homework", description: "Time to get smart!", status: false, completed: nil}
    ]
  end



end
