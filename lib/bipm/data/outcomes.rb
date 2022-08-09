require_relative "outcomes/body"
require_relative "outcomes/localized_body"
require_relative "outcomes/meeting"

module BIPM
  module Data
    module Outcomes
      def self.file_path
        "#{__dir__}/../../../"
      end

      def self.body(name)
        Body.new(name)
      end
      singleton_class.alias_method :[], :body

      def self.bodies
        %i[cctf cgpm cipm].to_h { |name| [name, body(name)] }
      end

      def self.each(&block)
        bodies.values.each(&block)
      end
      singleton_class.include Enumerable


      autoload :Body, "bipm/data/outcomes/body"
      autoload :LocalizedBody, "bipm/data/outcomes/localized_body"
      autoload :Meeting, "bipm/data/outcomes/meeting"
      autoload :Resolution, "bipm/data/outcomes/resolution"
      autoload :Approval, "bipm/data/outcomes/approval"
      autoload :Consideration, "bipm/data/outcomes/consideration"
      autoload :Action, "bipm/data/outcomes/action"
    end
  end
end
