# Ensure that a field contains only letters (a-z)

class TextKeyValidator < ActiveModel::EachValidator

  def self.compliant?(value)
    return value.match(/^[a-z\d-]+$/i).present?
  end

  def validate_each(record, attribute, value)
    unless value.present? && self.class.compliant?(value)
      record.errors.add(attribute, "must only contain letters, numbers, or dashes")
    end
  end

end