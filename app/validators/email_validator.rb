class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value =~ /\A([^@\s]+)@((?:[-_a-z0-9]+\.)+[-_a-z]{2,})\z/i
    message = options[:message] || "#{I18n.t('activerecord.errors.messages.email')}"
    record.errors[attribute] << message
  end
end
