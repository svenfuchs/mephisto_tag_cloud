controller_path = File.join(directory, 'lib', 'app', 'controllers')
$LOAD_PATH << controller_path
Dependencies.load_paths << controller_path
config.controller_paths << controller_path

require File.join(lib_path, 'drops')
require File.join(lib_path, 'url_filters')
require File.join(lib_path, 'plugin')

config.to_prepare do
  require_dependency 'tag_cloud'
  require_dependency File.join(lib_path, 'models')
  require_dependency File.join(lib_path, 'liquid', 'tag_cloud')
  Liquid::Template.register_tag('tagcloud', Liquid::TagCloud)
  # TagCloud.limit = 10
  # TagCloud.weights = 4
  # TagCloud.order = :alpha
  # TagCloud.method = :linear
  # TagCloud.method = lambda { |number| Math.log10 number + 2 }
end