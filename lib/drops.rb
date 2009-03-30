class TagDrop < BaseDrop
  # liquid_attributes.push *[:name]
  def name
    source.name
  end
  def weight
    source.weight if source.respond_to? :weight
  end
  def count
    source.count if source.respond_to? :count
  end
  def to_s
    source.name
  end
  private
  def gsub
    'kekse'
  end
end

