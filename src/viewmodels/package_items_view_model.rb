class PackageItemsViewModel
  def initialize(role)
    @role = role
  end

  def get_items
    @role.package.items
  end
end