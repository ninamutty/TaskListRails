class TasksController < ApplicationController
  before_action :find_user
  before_action :find_task, only: [:show, :edit, :complete, :destroy, :update]

  def index
    @tasks = Task.where(user_id: @user.id).order('id')
  end

  def show
    # raise
    if @task == nil
      flash[:notice] = "Task Does not Exist"
      redirect_to root_path
    end

    if @task.user_id != session[:user_id].to_i
      #...
    end

    if @task.user_id == @user.id
      return @task
    else
      flash[:notice] = "You Can Only See Tasks That Belong to You"
      redirect_to root_path
    end
  end

  def new
    @task = Task.new
    @post_path = tasks_path
    @post_method = :post
  end

  def edit
    if @task == nil
      flash[:notice] = "Task Does not Exist"
      redirect_to root_path
    end
    if @task.user_id == @user.id
      @post_path = task_path
      @post_method = :put
    else
      flash[:notice] = "You Can Only Edit Tasks That Belong to You"
      redirect_to root_path
    end
  end

  def update
    if @task == nil
      flash[:notice] = "Task Does not Exist"
      redirect_to root_path
    end

    if @task.user_id == @user.id
      if @task.update(task_params)
        @task.complete == true ? @task.completed_at = DateTime.now : @task.completed_at = nil
        redirect_to task_path(@task.id)
      else
        @error = "Did not save successfully. Please try again."
        @post_path = task_path(@task.id)
        @post_method = :put
        render :edit
      end
    else
      flash[:notice] = "You Can Only Update Tasks That Belong to You"
      redirect_to root_path
    end
  end

  def complete
    if @task == nil
      flash[:notice] = "Task Does not Exist"
      redirect_to root_path
    end

    if @task.user_id == @user.id
      if @task.complete == false
        @task.complete = true
        @task.completed_at = DateTime.now
        @task.save
      else
        @task.complete = false
        @task.completed_at = nil
        @task.save
      end
      redirect_to :back
    else
      flash[:notice] = "You Can Onle Update Tasks That Belong to You"
      redirect_to root_path
    end
  end

  def destroy
    if @task == nil
      flash[:notice] = "Task Does not Exist"
      redirect_to root_path
    end
    if @task.user_id == @user.id
      if @task.class == Task
        @task.destroy
        redirect_to tasks_path
      end
    else
      flash[:notice] = "You Can Only Edit Tasks That Belong to You"
      redirect_to root_path
    end
  end

  def create
    @task = Task.new(task_params)
    @task.complete == true ? @task.completed_at = DateTime.now : @task.completed_at = nil
    @task.user_id = @user.id

    if @task.save
      redirect_to tasks_path
    else
      @error = "Did not save successfully. Please try again."
      @post_path = merchant_product_tasks_path
      @post_method = :post
      render :new
    end
  end

  private
  def find_user
    if User.exists?(session[:user_id].to_i) == true
      return @user = User.find_by(id: session[:user_id].to_i)
    else
      render file: "#{Rails.root}/public/404.html", layout: true, status: 404
    end
  end

  def find_task
    if Task.exists?(params[:id].to_i) == true
      return @task = Task.find(params[:id].to_i)
    else
      render file: "#{Rails.root}/public/404.html", layout: true, status: 404
    end
  end

  def self.alltasks
    [
      {id: 1, title: "Groceries", description: "Go buy eggs, milk, cheese, yogurt, icecream, half and half, and any other dairy product you can think of", status: "no", completed: nil},
      {id: 2, title: "Workout", description: "Get your heart a pumpin!", status: "yes", completed: Date.new},
      {id: 3, title: "Homework", description: "Time to get smart!", status: "no", completed: nil}
    ]
  end

  def task_params
    params.require(:task).permit(:title, :description, :complete)
  end
end
