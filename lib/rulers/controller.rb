require_relative 'file_model'
require_relative 'view'
require 'rack/request'

module Rulers
  class Controller
    include Rulers::Model

    def initialize(env)
      @env = env
    end

    def env
      @env
    end

    def render(view_name, locals = {})
      filename = File.join 'app', 'views', controller_name, "#{view_name}.html.erb"
      ivars = instance_variables.reduce({}) {|ha, iv| ha[iv] = instance_variable_get(iv); ha }
      Rulers::View.new(filename, ivars, locals).result
    end

    def controller_name
      klass = self.class.to_s.gsub(/Controller$/, '')
      Rulers.to_underscore klass
    end

    def request
      @request ||= Rack::Request.new(env)
    end

    def params
      request.params
    end

    def response(text, status = 200, headers = {})
      raise "Already responded!" if @response
      @response = Rack::Response.new([text].flatten, status, headers)
    end

    def get_response
      @response
    end

    def render_response(*args)
      response render(*args)
    end

  end
end
