module BIPM
  module Data
    module Outcomes
      class Approval
        def initialize(resolution, index)
          @resolution = resolution
          @index = index

          raise IndexError unless document
        end

        def document
          @resolution.document.dig("approvals", index)
        end

        attr_reader :resolution, :index


        def message
          document["message"]
        end
      end
    end
  end
end
