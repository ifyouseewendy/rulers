require "rulers/version"
require 'rulers/array'
require 'rulers/routes'

module Rulers
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, {'Content-Type' => 'text/html'}, []]
      elsif env['PATH_INFO'] == '/'
        if Object.const_defined?('HomeController')
          text = Object.const_get('HomeController').send('index')
          return [200, {'Content-Type' => 'text/html'}, [text]]
        elsif File.exist?( f=File.join( File.dirname(__FILE__), '..', 'public', 'index.html') )
          return [200, {'Content-Type' => 'text/html'}, [File.read(f)]]
        else
          return [303, {'Location' => '/quotes/a_quote'}, []]
        end
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
