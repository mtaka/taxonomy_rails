require 'test_helper'

class TaxonomiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @taxonomy = taxonomies(:one)
  end

  test "should get index" do
    get taxonomies_url, as: :json
    assert_response :success
  end

  test "should create taxonomy" do
    assert_difference('Taxonomy.count') do
      post taxonomies_url, params: { taxonomy: { body: @taxonomy.body, description: @taxonomy.description, key: @taxonomy.key, name: @taxonomy.name, notes: @taxonomy.notes, owner: @taxonomy.owner, version: @taxonomy.version } }, as: :json
    end

    assert_response 201
  end

  test "should show taxonomy" do
    get taxonomy_url(@taxonomy), as: :json
    assert_response :success
  end

  test "should update taxonomy" do
    patch taxonomy_url(@taxonomy), params: { taxonomy: { body: @taxonomy.body, description: @taxonomy.description, key: @taxonomy.key, name: @taxonomy.name, notes: @taxonomy.notes, owner: @taxonomy.owner, version: @taxonomy.version } }, as: :json
    assert_response 200
  end

  test "should destroy taxonomy" do
    assert_difference('Taxonomy.count', -1) do
      delete taxonomy_url(@taxonomy), as: :json
    end

    assert_response 204
  end
end
