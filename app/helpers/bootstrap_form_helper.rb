module BootstrapFormHelper

  class BootstrapFormBuilder < ActionView::Helpers::FormBuilder

    def field(type, attribute, label_text = nil, options = {})
      output = @template.content_tag(:div, class: 'form-group') do
        nested_output = label(attribute, label_text)
        add_classes('form-control', options)
        nested_output += @template.send(type, @object_name, attribute, options)
      end
      output
    end

    def submit(value = nil, options = {})
      add_classes('btn btn-primary', options)
      super(value, options)
    end

    private

      def add_classes(classes, options)
        if options[:class]
          options[:class] += ' ' + classes
        else
          options[:class] = classes
        end
      end

  end

  def bootstrap_form_for(object, options = {}, &block)
    options[:builder] = BootstrapFormBuilder
    form_for(object, options, &block)
  end

end
