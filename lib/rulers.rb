require "rulers/version"
require 'rulers/array'
require 'rulers/routes'

module Rulers
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, {'Content-Type' => 'text/html'}, []]
      end

      begin
        klass, action = get_controller_and_action(env)
        controller = klass.new(env)
        text = controller.send(action)
        [200, {'Content-Type' => 'text/html'}, [text]]
      rescue => e
        puts "Exception raised: #{e.message}"
        [500, {'Content-Type' => 'text/html'}, ['Server error']]
      end
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end
    def env
      @env
    end
  end
end
