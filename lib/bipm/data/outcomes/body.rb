module BIPM
  module Data
    module Outcomes
      class Body
        def initialize(body, locale = nil)
          @body = body
        end

        attr_reader :body

        def file_path
          "#{Outcomes.file_path}#{@body}/"
        end


        def locale(name)
          LocalizedBody.new(@body, name)
        end
        alias [] locale

        def locales
          %i[fr en].to_h { |name| [name, locale(name)] }
        end

        def each(&block)
          locales.values.each(&block)
        end
        include Enumerable
      end
    end
  end
end
