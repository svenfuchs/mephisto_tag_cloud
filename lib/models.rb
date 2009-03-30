Site.class_eval do
  def tags_with_count(options = {})
    options.merge! :conditions => ['contents.type = ? AND contents.site_id = ?', 'Article', id]
    Tag.find_all_with_count options
  end
end

Tag.class_eval do
  attr_accessor :weight
  
  class << self
    def find_all_with_count(options = {})
      options.merge! :select => "tags.*, COUNT(*) as count", :group => "tags.id",
                     :joins  => %( LEFT JOIN taggings ON taggings.tag_id = tags.id
                                   LEFT JOIN contents ON contents.id = taggings.taggable_id AND contents.published_at IS NOT NULL )
      Tag.find :all, options  
    end
  end  
  
  def to_liquid
    TagDrop.new self
  end
end