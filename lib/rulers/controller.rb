module Rulers
  class Controller
    def initialize(env)
      @env = env
    end
    def env
      @env
    end

    def render(view_name, locals = {})
      filename = File.join 'app', 'views', controller_name, "#{view_name}.html.erb"
      eruby = Erubis::Eruby.new( File.read(filename) )
      eruby.result locals.merge(:env => env)
    end

    def controller_name
      klass = self.class.to_s.gsub(/Controller$/, '')
      Rulers.to_underscore klass
    end
  end
end
