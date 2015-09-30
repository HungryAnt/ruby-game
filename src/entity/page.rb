class Page
  attr_reader :total_count, :page_no, :page_size, :result

  def initialize(total_count, page_no, page_size, result)
    @total_count = total_count
    @page_no, @page_size = page_no, page_size
    @result = result
  end

  def self.from_map(map)
    Page.new(map['totalCount'].to_i,
             map['pageNo'].to_i,
             map['pageSize'].to_i,
             map['result'])
  end
end