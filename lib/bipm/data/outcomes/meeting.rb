require "yaml"
require "date"

module BIPM
  module Data
    module Outcomes
      class Meeting
        def initialize(body, id)
          @id = id
          @body = body

          raise IndexError unless File.exist? file_path
        end

        attr_reader :body, :id

        def file_path
          "#{@body.file_path}meeting-#{id}.yml"
        end

        def document
          YAML.load(File.open(file_path))
        end


        def title
          document["metadata"]["title"]
        end

        def date
          Date.parse(document["metadata"]["date"])
        end

        def source
          document["metadata"]["source"]
        end

        def url
          document["metadata"]["source"]
        end

        def pdf
          document["pdf"]
        end


        def resolution(name)
          Resolution.new(self, name)
        end
        alias [] resolution

        def resolutions
          document["resolutions"].each_with_index.to_h { |_,name| [name, resolution(name)] }
        end

        def each(&block)
          resolutions.values.each(&block)
        end
        include Enumerable
      end
    end
  end
end
