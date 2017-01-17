#
# Cookbook Name:: miovim
# Recipe:: vim
#
# Copyright (c) 2017 The Authors, All Rights Reserved.



package node['miovim']['package'] 

template "#{node['miovim']['home']}/.vimrc" do
    source 'vimrc.erb'
end
