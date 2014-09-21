module Rulers
  class View
    def initialize(filename, ivars = {}, locals = {})
      @_filename = filename
      @_ivars = ivars
      @_locals = locals
    end

    def result
      eruby = Erubis::Eruby.new( File.read(@_filename) )
      eruby.result @_locals.merge(@_ivars)
    end
  end
end
