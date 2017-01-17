
package 'git'

directory "#{node['miovim']['home']}/.vim/bundle" do
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


ruby_block 'install fugitive plugin' do
    block do
        file = Chef::Util::FileEdit.new("#{node['miovim']['vim']['home']}/config/vundle.vim")
        file.insert_line_after_match(/Plugin 'VundleVim\/Vundle.vim'/, "Plugin 'tpope/vim-fugitive'")
        file.write_file
    end
    not_if { ::File.readlines("#{node['miovim']['vim']['home']}/config/vundle.vim").grep("Plugin 'tpope/vim-fugitive'").any?}
end

bash 'run_vim_PluginInstall' do
    code 'vim +PluginInstall +qall'
end


