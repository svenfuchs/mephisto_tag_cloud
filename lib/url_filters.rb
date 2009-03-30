UrlFilters.module_eval do
  def link_to_tag(tag)    
    content_tag :a, h(tag), :href => tag_url(tag), :rel => 'tag', 
                :class => (tag.weight.nil? ? nil : "weight-#{tag.weight}"),
                :title => (tag.count.nil? ? nil : "#{h(tag)} (#{tag.count})") 
  end
end


