require 'sqlite3'
require_relative 'util'

DB = SQLite3::Database.new 'test.db'

module Rulers
  module Model
    class SQLite

      class << self
        def table
          Rulers.to_underscore name
        end

        def schema
          return @schema if @schema
          @schema = {}
          DB.table_info(table) do |row|
            @schema[ row['name'] ] = row['type']
          end
          @schema
        end

        def to_sql(val)
          case val
          when Numeric
            val.to_s
          when String
            "'#{val}'"
          else
            raise "Can't change #{val.class} to SQL!"
          end
        end

        def create(values)
          values.delete 'id'
          keys = schema.keys - ['id']
          vals = keys.map do |key|
            values[key] ? to_sql(values[key]) : 'null'
          end

          DB.execute <<SQL
            INSERT INTO #{table} (#{keys.join(',')})
            VALUES (#{vals.join(',')});
SQL

          data = Hash[keys.zip(vals)]
          sql = "SELECT last_insert_rowid();"
          data['id'] = DB.execute(sql)[0][0]
          self.new data
        end

        def count
          DB.execute(<<SQL)[0][0]
            SELECT COUNT(*) FROM #{table}
SQL
        end

        def find(id)
          row = DB.execute <<SQL
            SELECT #{schema.keys.join(',')} from #{table} where id=#{id}
SQL
          data = Hash[ schema.keys.zip row[0] ]
          self.new data
        end
      end

      def initialize(data = nil)
        @hash = data
      end

      def [](name)
        @hash[name.to_s]
      end

      def []=(name, value)
        @hash[name.to_s] = value
      end

      def save!
        unless @hash['id']
          self.class.create
          return true
        end

        fields = @hash.map do |k,v|
          "#{k}=#{self.class.to_sql(v)}"
        end.join(',')

        DB.execute <<SQL
          UPDATE #{self.class.table}
          SET #{fields}
          WHERE id="#{@hash['id']}"
SQL
        true
      end

      def save
        save! rescue false
      end

    end
  end
end
