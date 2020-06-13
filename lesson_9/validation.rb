# frozen_string_literal: true

module Validation

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validates

    def validate(attr, type, options = nil)
      @validates ||= []
      @validates << { attr: attr, type: type, options: options }
    end
  end


  module InstanceMethods
    def validate!
      self.class.validates.each do |validate|
        value = instance_variable_get("@#{validate[:attr]}")

        send("validate_#{validate[:type]}", value, *validate[:options])
      end
    end

    def validate_presence(value)
      raise 'Переменная пуста' if value == nil || value == ''
    end

    def validate_format(value, options)
      raise 'Не соответствует фомату' if value !~ options
    end

    def validate_type(value, options)
      raise 'Не корректный тип' unless value.is_a?(type)
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end
