require 'test_helper'

class PageResControllerTest < ActionDispatch::IntegrationTest
  setup do
    @page_re = page_res(:one)
  end

  test "should get index" do
    get page_res_url, as: :json
    assert_response :success
  end

  test "should create page_re" do
    assert_difference('PageRe.count') do
      post page_res_url, params: { page_re: { description: @page_re.description, owner: @page_re.owner, url: @page_re.url } }, as: :json
    end

    assert_response 201
  end

  test "should show page_re" do
    get page_re_url(@page_re), as: :json
    assert_response :success
  end

  test "should update page_re" do
    patch page_re_url(@page_re), params: { page_re: { description: @page_re.description, owner: @page_re.owner, url: @page_re.url } }, as: :json
    assert_response 200
  end

  test "should destroy page_re" do
    assert_difference('PageRe.count', -1) do
      delete page_re_url(@page_re), as: :json
    end

    assert_response 204
  end
end
