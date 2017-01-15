#
# Cookbook Name:: miovim
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.



package node['miovim']['package'] 

template '~/.vimrc' do
    source 'vimrc.erb'
end
