# validates each json property and bubbles up any errors
# also throws a generic can not be blank error, in the event
# that a hash is not provided
class JsonAttributeValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    json_attribute = object.class.json_attribute_fields[attribute]

    unless value.is_a?(json_attribute) && value.valid?
      if value.is_a?(json_attribute)
        value.errors.messages.each_pair do |k,v|
          object.errors["#{attribute}.#{k}"] << v
        end
      else
        object.errors[attribute] = "can not be blank"
      end
    end
  end
end
