module Trice
  module ControllerMethods
    class ReferenceTimeAssignment

      QUERY_STUB_KEY  = '_requested_at'.freeze
      HEADER_STUB_KEY = 'X-REQUESTED-AT'.freeze

      def initialize(config)
        @stub_configuration = config
      end

      def around(controller, &action)
        t = determine_requested_at(controller)

        Trice.with_reference_time(t, &action)
      end

      private

      def determine_requested_at(controller)
        if @stub_configuration.stubbable?(controller)
          extract_requested_at(controller.request) || Time.now
        else
          Time.now
        end
      end

      def extract_requested_at(request)
        if request.params[QUERY_STUB_KEY]
          Time.zone.parse(request.params[QUERY_STUB_KEY])
        elsif request.headers[HEADER_STUB_KEY]
          Time.zone.parse(request.headers[HEADER_STUB_KEY])
        end
      end
    end
  end
end
