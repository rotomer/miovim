
case node['platform']
when 'ubuntu'
    default['miovim']['package'] = 'vim'
when 'centos'
    default['miovim']['package'] = 'vim-enhanced'
end

default['miovim']['home'] = '/home/vagrant'
default['miovim']['vim']['home'] = "#{node['miovim']['home']}/.vim"
