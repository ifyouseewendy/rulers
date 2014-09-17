require_relative 'test_helper'

class TestApp < Rulers::Application
end

class RulersAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    TestApp.new
  end

  def test_request
    get '/test'

    assert last_response.ok?
    body = last_response.body
    assert body['Hello']
  end

  # def test_to_underscore
  #   word = 'Rulers::HttpController'
  #   assert_equal 'rulers/http_controller', word.to_underscore

  #   word = 'Ruler::HTTPController'
  #   assert_equal 'rulers/http_controller', word.to_underscore

  #   word = 'Ruler::H4Controller'
  #   assert_equal 'rulers/http_controller', word.to_underscore
  # end
end
