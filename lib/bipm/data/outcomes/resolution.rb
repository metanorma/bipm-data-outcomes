require "date"

module BIPM
  module Data
    module Outcomes
      class Resolution
        def initialize(meeting, index)
          @meeting = meeting
          @index = index

          raise IndexError unless document
        end

        def document
          @meeting.document["resolutions"][index]
        end

        attr_reader :meeting, :index


        def dates
          document["dates"].map { |i| Date.parse(i) }
        end

        def subject
          document["subject"]
        end
        
        def type
          document["type"].to_sym
        end

        def id
          document["identifier"]
        end

        def url
          document["url"]
        end

        def reference
          document["reference"]
        end

        def reference_name
          document["reference_name"]
        end

        def reference_page
          document["reference_page"]
        end


        def approval(name)
          Approval.new(self, name)
        end

        def approvals
          return {} unless document["approvals"]
          document["approvals"].each_with_index.to_h { |_,name| [name, approval(name)] }
        end


        def consideration(name)
          Consideration.new(self, name)
        end

        def considerations
          return {} unless document["considerations"]
          document["considerations"].each_with_index.to_h { |_,name| [name, consideration(name)] }
        end


        def action(name)
          Action.new(self, name)
        end

        def actions
          return {} unless document["actions"]
          document["actions"].each_with_index.to_h { |_,name| [name, action(name)] }
        end
      end
    end
  end
end
