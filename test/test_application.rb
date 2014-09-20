require_relative 'test_helper'

class TestController < Rulers::Controller
  def index
    'Hello!'
  end
end

class TestApp < Rulers::Application
  def get_controller_and_action
    ['TestController', 'index']
  end
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

  def test_file_model
    test_file = File.expand_path("../../db/quotes/9999.json", __FILE__)
    begin
      assert_nil Rulers::Model::FileModel.find(9999)

      File.open(test_file, 'w') do |f|
        f.puts <<-HERE
          {
            "name": "wendi",
            "age": "25"
          }
        HERE
      end

      fm = Rulers::Model::FileModel.new(test_file)
      assert_equal 'wendi', fm['name']
      fm['gender'] = 'male'
      assert_equal 'male', fm['gender']

      assert !Rulers::Model::FileModel.find(9999).nil?
    ensure
      File.delete test_file
    end
  end
end
