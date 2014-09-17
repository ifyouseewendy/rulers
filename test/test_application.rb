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

  def test_to_underscore
    word = 'Rulers::HttpController'
    assert_equal 'rulers/http_controller', Rulers.to_underscore(word)

    word = 'Rulers::HTTPController'
    assert_equal 'rulers/http_controller', Rulers.to_underscore(word)

    word = 'Rulers::H4Controller'
    assert_equal 'rulers/h4_controller', Rulers.to_underscore(word)
  end
end
