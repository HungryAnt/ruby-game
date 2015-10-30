lambda {
  map = {}

  Kernel.send :define_method, :get_instance do |clazz|
    instance = map[clazz]
    if instance.nil?
      instance = clazz.new
      map[clazz] = instance
    end
    instance
  end

  Kernel.send :define_method, :autowired do |*classes|
    classes.each do |clazz|
      underscore_class_name = clazz.name.to_s.gsub(/(.)([A-Z])/, '\1_\2').downcase
      instance_variable_set("@#{underscore_class_name}", get_instance(clazz))
    end
  end
}.call