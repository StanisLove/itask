class Role
  @enums = { common: 0, admin: 1 }

  attr_reader :key, :value

  class << self
    attr_reader :enums
  end

  def initialize(key = nil)
    return if key.nil?
    return init_by_key(key) if key.is_a?(Symbol)
    init_by_value(key)
  end

  def self.value(key)
    @enums[key] if @enums.key?(key)
  end

  protected

  def init_by_key(key)
    fail ArgumentError, "Undefined key!" unless self.class.enums.key?(key)

    @key = key
    @value = self.class.enums[key]
  end

  def init_by_value(val)
    key = self.class.enums.key(val)
    return if key.nil?
    init_by_key(key)
  end
end
