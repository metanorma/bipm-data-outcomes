module BIPM
  module Data
    module Outcomes
      class LocalizedBody < Body
        def initialize(body, locale)
          super
          @locale = locale
        end

        attr_reader :locale

        def file_path
          "#{super}meetings-#{@locale}/"
        end


        def meeting(name)
          Meeting.new(self, name)
        end
        alias [] meeting

        def meetings
          Dir["#{file_path}*"].to_h { |name| name = name.split("-").last.split(".").first; [name, meeting(name)] }
        end
        
        def each(&block)
          meetings.values.each(&block)
        end
        include Enumerable
      end
    end
  end
end
