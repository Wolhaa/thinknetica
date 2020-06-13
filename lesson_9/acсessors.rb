
module Acсessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_history = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("@#{name}=".to_sym) do |value|
        history = instance_variable_get(var_history) || []
        preceding_var = instance_variable_get(var_name)
        instance_variable_set(var_history, history << preceding_var) if preceding_var
        instance_variable_set(var_name, value)
      end
      define_method("#{name}_history") { instance_variable_get(var_history)}
    end
  end

  def strong_attr_accessor(attribute, var_class)
    var_name = "@#{attribute}"
    define_method(attribute) { instance_variable_get(var_name) }
    define_method("@#{attribute}=".to_sym) do |value|
      raise "#{value} should be a #{var_class}" unless value.is_a?(var_class)

      instance_variable_set(var_name, value)
    end
  end
end
