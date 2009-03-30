class Liquid::TagCloud < Liquid::Block
  
  Syntax = /as\s(#{Liquid::VariableSignature}+)/ unless const_defined?('Syntax') # stupid plugin reloading issue

  def initialize(tag_name, markup, tokens)
    super
    markup =~ Syntax
    @param = $1
    raise "Syntax Error in tag 'tagcloud' - Valid syntax: {tagcloud as tag} ... {endtagcloud}" unless @param    
  end

  def render(context)
    i = -1
    TagCloud.new(context['site'].source).tags.collect do |tag|
      context[@param] = tag
      context['index'] = (i += 1)      
      render_all(@nodelist, context)
    end
  end
end