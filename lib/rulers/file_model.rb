module Rulers
  module Model
    class FileModel

      class << self
        def find(id)
          begin
            FileModel.new("db/quotes/#{id}.json")
          rescue
            return nil
          end
        end

        def all
          files = Dir['db/quotes/*.json']
          files.map{|f| FileModel.new f}
        end

        def create(attrs)
          hash = {}
          hash["submitter"] = attrs["submitter"] || ""
          hash["quote"] = attrs["quote"] || ""
          hash["attribution"] = attrs["attribution"] || ""

          numbers = Dir['db/quotes/*.json'].map{|f| f.split('/')[-1]}
          highest = numbers.map(&:to_i).max
          id = highest + 1

          File.open("db/quotes/#{id}.json", 'w') do |f|
            f.write <<-HERE
              {
                "submitter": "#{hash["submitter"]}",
                "quote": "#{hash["quote"]}",
                "attribution": "#{hash["attribution"]}"
              }
            HERE
          end

          FileModel.new "db/quotes/#{id}.json"
        end
      end

      def initialize(filename)
        @filename = filename

        basename = File.split(filename)[-1]
        @id = File.basename(basename, '.json').to_i

        @hash = MultiJson.load( File.read(filename) )
      end

      def [](name)
        @hash[name.to_s]
      end

      def []=(name, value)
        @hash[name.to_s] = value
      end

    end
  end
end
