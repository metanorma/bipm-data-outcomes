require 'date'

module BIPM
  module Data
    module Outcomes
      class Action
        def initialize(resolution, index)
          @resolution = resolution
          @index = index

          raise IndexError unless document
        end

        def document
          @resolution.document.dig("actions", index)
        end

        attr_reader :resolution, :index


        def type
          document["type"].to_sym
        end

        def date_effective
          Date.parse(document["date_effective"])
        end

        def message
          document["message"]
        end
      end
    end
  end
end
