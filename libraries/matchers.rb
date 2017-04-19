if defined?(ChefSpec)
  def install_miovim_vim_plugin(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('miovim_vim_plugin', 'install', resource_name)
  end
  def remove_miovim_vim_plugin(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('miovim_vim_plugin', 'remove', resource_name)
  end
en  
