# frozen_string_literal: true

module Alchemy
  module Forms
    class Builder < SimpleForm::FormBuilder
      # Renders a simple_form input, but uses input alchemy_wrapper
      #
      def input(attribute_name, options = {}, &block)
        options[:wrapper] = :alchemy

        if object.respond_to?(:attribute_fixed?) && object.attribute_fixed?(attribute_name)
          options[:disabled] = true
          options[:input_html] = options.fetch(:input_html, {}).merge(
            'data-alchemy-tooltip' => Alchemy.t(:attribute_fixed, attribute_name)
          )
        end

        super
      end

      # Renders a button tag wrapped in a div with 'submit' class.
      #
      def submit(label, options = {})
        options = {class: 'submit'}.update(options[:wrapper_html] || {})
        template.content_tag('div', options) do
          template.content_tag('button', label, options[:input_html])
        end
      end
    end
  end
end
