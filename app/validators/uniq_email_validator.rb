class UniqEmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil? || !User.exists?(email: value.downcase)
    message = options[:message] || "#{I18n.t('users.errors.email_not_uniqueness')}"
    record.errors[attribute] << message
  end
end
