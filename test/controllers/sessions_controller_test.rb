require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  # Can the user Log in
  # number of users increases when new user logs in
  # What happens when they log in twice
  # Session variable
  # log out

  #OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({provider: 'github', uid: '12342', info: {email: 'a@b.com', name: "Ada"}})

  setup do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
  end

  # test "should be able to create a new product" do
  #   post_params =  {name: "Glitter Wand", description: "a glittery wand", price: "15.00", image: 'http://placekitten.com/200/300', merchant_id: 2, inventory: 7, rating: 5}
  #
  #   post :create, {merchant_id: (products(:glitter).merchant).id, product: post_params}
  #   assert_response :redirect
  # end


  test "should be able to create a new user" do
    puts "User: #{@current_user}"
    # puts "User id: #{@user.id}"
    get :create, {provider: 'github'}
    assert session[:user_id] == @current_user.id
    assert_redirected_to tasks_path
  end

  test "creating a new user should add a user to the data base" do
    assert_difference("User.count", 1) do
      get :create, {provider: 'github'}
    end
  end

  test "A User logging in again should not add a user to the data base" do
    get :create, {provider: 'github'}

    assert_difference("User.count", 0) do
      get :create, {provider: 'github'}
    end
  end

  test "A user logging out should set the session[user_id] to nil" do
    get :create, {provider: 'github'}

    delete :destroy
    assert_redirected_to root_path
    assert_equal current_user, nil
  end

end
