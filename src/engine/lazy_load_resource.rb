class LazyLoadResource
  def initialize(&load_action)
    @load_action = load_action
    @resource = nil
  end

  def method_missing(method, *args)
    if @resource.nil?
      @resource = @load_action.call
    end
    @resource.send method, *args
  end
end