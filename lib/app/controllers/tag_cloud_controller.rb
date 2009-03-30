class TagCloudController < ApplicationController
  
  self.view_paths = File.join(File.dirname(__FILE__), '..', 'views')
  layout nil
  session :off
  before_filter :set_site
  
  def distribution
    # TagCloud.method = :linear
    # TagCloud.method = :log
    # TagCloud.method = :power
    # TagCloud.order = :weight
    # TagCloud.weights = 8
    @cloud = TagCloud.new(@site)    
  end
  
  private
  
  def set_site
    @site ||= Site.find_by_host(host) || Site.find(:first, :order => 'id')
  end
end
