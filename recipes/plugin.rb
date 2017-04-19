
#  vim: set ft=ruby.chef:
#
# Cookbook Name:: miovim
# Recipe:: plugin
#
# Copyright (c) 2017 The Authors, All Rights Reserved.


package 'git'

directory "#{node['miovim']['vim']['home']}/bundle" do
    recursive true
    action :create
end

git "#{node['miovim']['vim']['home']}/bundle/Vundle.vim" do
    repository 'https://github.com/VundleVim/Vundle.vim.git'
    revision 'master'
    action :sync
end

directory "#{node['miovim']['vim']['home']}/config" do
    recursive true
    action :create
end

template "#{node['miovim']['vim']['home']}/config/vundle.vim" do
    source 'vundle.vim.erb'
end

ruby_block 'insert source vundle' do
    block do
        file = Chef::Util::FileEdit.new("#{node['miovim']['home']}/.vimrc")
        file.insert_line_if_no_match("/source #{node['miovim']['vim']['home']}\/config\/vundle.vim/", "source #{node['miovim']['vim']['home']}/config/vundle.vim")
        file.write_file
    end
    not_if "grep config\/vundle.vim #{node['miovim']['home']}/.vimrc"
end

node['miovim']['vim']['plugin_list'].each do |plugin|
    miovim_vim_plugin plugin do
        vim_home  node['miovim']['vim']['home']
    end
#    ruby_block "install #{plugin} plugin" do
#        block do
#            file = Chef::Util::FileEdit.new("#{node['miovim']['vim']['home']}/config/vundle.vim")
#            file.insert_line_after_match(/Plugin 'VundleVim\/Vundle.vim'/, "Plugin '#{plugin}'")
#            file.write_file
#        end
#            not_if { ::File.readlines("#{node['miovim']['vim']['home']}/config/vundle.vim").grep("Plugin '#{plugin}'").any?}
#    end
end

#bash 'run_vim_PluginInstall' do
#    code 'vim +PluginInstall +qall'
#end


