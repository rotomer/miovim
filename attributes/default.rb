
case node['platform']
when 'ubuntu'
    default['miovim']['package'] = 'vim'
when 'centos'
    default['miovim']['package'] = 'vim-enhanced'
end

default['miovim']['home'] = '/home/vagrant'
default['miovim']['vim']['home'] = "#{node['miovim']['home']}/.vim"

#List of plugins to install. Only Vundle github syntax is supported. see Vundle README for details
default['miovim']['vim']['plugin_list'] = ['tpope/vim-fugitive', 
                                           'scrooloose/nerdtree', 
                                           'vim-ruby/vim-ruby', 
                                           't9md/vim-chef']
