require 'test_helper'

class HostaCentralControllerControllerTest < ActionController::TestCase
  test "should get registerPeer" do
    get :registerPeer
    assert_response :success
  end

  test "should get registerBackup" do
    get :registerBackup
    assert_response :success
  end

  test "should get browsePage" do
    get :browsePage
    assert_response :success
  end

  test "should get updatePage" do
    get :updatePage
    assert_response :success
  end

  test "should get hostPage" do
    get :hostPage
    assert_response :success
  end

end
