# Based on code from https://stackoverflow.com/questions/7167895/rails-whats-a-good-way-to-validate-links-urls
# Validates an HTTPS URL, use by adding "https: true" to validation string

class HTTPSValidator < ActiveModel::EachValidator

  def self.compliant?(value)
    uri = URI.parse(value)
    return uri.is_a?(URI::HTTPS) && !uri.host.nil?
  rescue URI::InvalidURIError
    return false
  end

  def validate_each(record, attribute, value)
    unless value.present? && self.class.compliant?(value)
      record.errors.add(attribute, "is not a valid HTTPS URL")
    end
  end

end