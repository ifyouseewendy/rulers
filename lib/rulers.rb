require "rulers/version"
require 'rulers/array'
require 'rulers/util'
require 'rulers/dependencies'
require 'rulers/controller'
require 'rulers/file_model'
require 'rulers/routing'
require 'pry'

module Rulers
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, {'Content-Type' => 'text/html'}, []]
      elsif env['PATH_INFO'] == '/'
        # if Object.const_defined?('HomeController')
        #   text = Object.const_get('HomeController').new(env).send('index')
        #   return [200, {'Content-Type' => 'text/html'}, [text]]
        # elsif File.exist?( f=File.join( env['ROOT_DIR'].to_s, 'public', 'index.html') )
        #   return [200, {'Content-Type' => 'text/html'}, [File.read(f)]]
        # else
        #   return [303, {'Location' => '/quotes/a_quote'}, []]
        # end
      elsif env['PATH_INFO'] == '/test'
        return [200, {'Content-Type' => 'text/html'}, ['Hello world']]
      end

      begin
        rack_app = get_rack_app(env)
        rack_app.call(env)

        # klass, action = get_controller_and_action(env)
        # controller = klass.new(env)
        # text = controller.send(action)

        # # call render automatically
        # controller.render_response action.to_sym unless controller.get_response
        # st, hd, rs = controller.get_response.to_a
        # [st, hd, [rs.body].flatten]
      rescue => e
        puts "Exception raised: #{e.message}"
        puts e.backtrace
        [500, {'Content-Type' => 'text/html'}, ['Server error']]
      end
    end

  end

end
