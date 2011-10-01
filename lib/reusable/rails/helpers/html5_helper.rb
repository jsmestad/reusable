# Adds support for various HTML5 Boilerplate methods.
# This is assuming you are using the partials found under
# the ./helpers/html5_helper/ sub-folder in this project.
#
module Reusable::Rails
  module Helpers
    module Html5Helper
      extend ActiveSupport::Concern

      module InstanceMethods
        # Create a named haml tag to wrap IE conditional around a block
        # http://paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither
        def ie_tag(name=:body, attrs={}, &block)
          attrs.symbolize_keys!
          haml_concat("<!--[if lt IE 7]> #{ tag(name, add_class('ie6', attrs), true) } <![endif]-->".html_safe)
          haml_concat("<!--[if IE 7]>    #{ tag(name, add_class('ie7', attrs), true) } <![endif]-->".html_safe)
          haml_concat("<!--[if IE 8]>    #{ tag(name, add_class('ie8', attrs), true) } <![endif]-->".html_safe)
          haml_concat("<!--[if gt IE 8]><!-->".html_safe)
          haml_tag name, attrs do
            haml_concat("<!--<![endif]-->".html_safe)
            block.call
          end
        end

        def ie_html(attrs={}, &block)
          ie_tag(:html, attrs, &block)
        end

        def ie_body(attrs={}, &block)
          ie_tag(:body, attrs, &block)
        end

        # Fetch the Google Account ID for this application from either
        # the 'GOOGLE_ACCOUNT_ID' environment variable or from the
        # config/google.yml file.
        #
        # @return [String]
        # @see #google_config
        def google_account_id
          ENV['GOOGLE_ACCOUNT_ID'] or google_config(:google_account_id)
        end

        # Fetch the Google API ID for this application from either
        # the 'GOOGLE_API_ID' environment variable or from the
        # config/google.yml file.
        #
        # @return [String]
        # @see #google_config
        def google_api_key
          ENV['GOOGLE_API_KEY'] or google_config(:google_api_key)
        end

        # Generates the Google API code for serving jQuery either
        # compressed or uncompressed.
        #
        # @param [String] jQuery version number
        # @return [String] Google API string
        def google_cdn_jquery(version='1.6.2')
          if Rails.env.development?
            "'jquery', '#{version}', {uncompressed:true}"
          else
            "'jquery', '#{version}'"
          end
        end

        # Generates the jQuery file extension for including
        # jQuery from the Google CDN
        #
        # @param [String] jQuery version number
        # @return [String]
        def remote_jquery(version='1.6.2')
          if Rails.env.development?
            "#{version}/jquery.js"
          else
            "#{version}/jquery.min.js"
          end
        end

      private

        def add_class(name, attrs)
          classes = attrs[:class] || ''
          classes.strip!
          classes = ' ' + classes if !classes.blank?
          classes = name + classes
          attrs.merge(:class => classes)
        end

        # @return [Hash] loaded YAML config
        # @see #google_api_key #google_account_id
        def google_config(key)
          @google_config ||= YAML.load_file(File.join(Rails.root, 'config', 'google.yml'))[Rails.env] rescue {}
          @google_config.has_key?(key) ? @google_config[key] : nil
        end
      end
    end
  end
end
