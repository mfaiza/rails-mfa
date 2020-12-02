require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "create new category form and create category" do
    get '/categories/new'
    assert_response :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: "News" }}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "News", response.body
  end

  test "create new category form and reject invalid category submission" do
    get '/categories/new'
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: " " }} 
    end
    assert_match "Errors", response.body
    assert_select 'div.alert'
    assert_select 'h2.alert-heading'
  end

end
