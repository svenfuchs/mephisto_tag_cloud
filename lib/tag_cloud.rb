require_dependency 'models/site'
require_dependency 'models/tag'

class TagCloud
  cattr_accessor :weights, :method, :order, :limit
  @@weights = 10
  @@method = :log
  @@order = :alpha
  @@limit = nil
  
  def initialize(site)
    @site = site
  end
  
  def tags
    @tags ||= raw_tags.each do |tag|
      thresholds.each_with_index do |threshold, i|
        tag.weight = i + 1 if (compute(tag.count.to_i) <= threshold) && tag.weight.nil?
      end
    end 
  end
  
  def to_array
    tags.collect {|tag| [tag.name, tag.count.to_i]}
  end
  
  def min
    @min ||= counts.min
  end
  
  def max
    max ||= counts.max
  end
  
  def thresholds
    @thresholds ||= (1..weights).inject([]) do |res, x|
      res << min + x * (max - min) / weights.to_f; res
    end
  end
  
  private
  
  def raw_tags
    @raw_tags ||= @site.tags_with_count :order => order_sql, :limit => limit
  end
  
  def counts
    @counts ||= raw_tags.inject([]) { |res, tag| res << tag.count.to_i; res }.uniq    
  end
  
  def compute(value)
    case method
      when :linear
        value
      when :log        
        Math.log(value) * max / Math.log(max)
      when :power
        (value * value / max).round.to_f
      else        
        method.call(value) # TODO needs to be a lambda
    end
  end
  
  def order_sql 
    raise "Invalid value for TagCloud.order (#{order.inspect}). Valid values are: :weight, :alpha." unless [:weight, :alpha].include?(order) 
    order == :weight ? "count DESC" : "tags.name"
  end  
end