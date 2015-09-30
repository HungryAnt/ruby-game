require_relative 'page'

class PageResult
  attr_reader :page

  def initialize(page)
    @page = page
  end

  def self.from_map(map)
    page = Page.from_map(map['page'])
    PageResult.new(page)
  end
end