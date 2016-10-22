require 'test_helper'

class TasksControllerTest < ActionController::TestCase

  test "make sure a user can see their tasks" do
    session[:user_id] = users(:ada).id
    get :show, id: tasks(:adas_task).id

    assert_response :success
  end

  test "make sure a user can not see other's tasks" do
    session[:user_id] = users(:babbage).id
    get :show, id: tasks(:adas_task).id

    assert_response :redirect
    assert_equal flash[:notice], "You do not have access to that task."
  end

  ## DO A WEEK FROM WEDNESDAY
    # Do a model migration so tasks belong to user and each user has their own list of tasks
    # Practice writing a couple basic tasks

  
end
