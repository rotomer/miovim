
case platform
when 'ubuntu'
    default['miovim']['package'] = 'vim'
when 'centos'
    default['miovim']['package'] = 'vim-enhanced'
end
