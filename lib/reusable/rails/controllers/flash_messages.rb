module Reusable::Rails
  module Controllers
    module FlashMessages
      extend ActiveSupport::Concern

      included do
        after_filter :flash_messages_for_xhr
      end

      # Helper for supporting multiple flash messages per type
      #
      # @param [Symbol] the type of flash message. Common types are
      # :success, :notice, :error
      # @param [String] the message to attach to the flash type
      # @return [Hash] all associated flash messages for this request
      def flash_message(type, text)
        flash[type.to_sym] ||= []
        flash[type.to_sym] << text
      end

      # Return any flash messages added for the request, optionally can
      # be formatted to return a JSON representation.
      #
      # @params [Hash] accepts :json => true flag
      def flash_messages(options={})
        if !!options[:json]
          Hash[flash.collect do |type, messages|
            [k, messages.is_a?(Array) ? messages.collect {|i| ERB::Util.h(i)} : ERB::Util.h(messages)]
          end].to_json
        else
          flash
        end
      end

    protected
      # For XHR (AJAX requests) send the flash messages
      # back in the X-Flash-Messages header field as JSON.
      def flash_messages_for_xhr
        return unless request.xhr?
        response.headers['X-Flash-Messages'] = flash_messages(:json => true)
        flash.discard
      end
    end
  end
end
