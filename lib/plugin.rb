module Mephisto
  module Plugins
    class TagCloud < Mephisto::Plugin
      author 'Sven Fuchs'
      version '0.1'
      homepage 'http://www.artweb-design.de/projects/mephisto_tag_cloud'
      notes "Liquid Plugin to display a tag cloud in your Mephisto templates. See homepage for credits!"
      # option :limit, 0 # TODO this is not used, yet      
      add_route 'tagcloud/distribution', :controller => 'tag_cloud', :action => 'distribution'
    end
  end
end
