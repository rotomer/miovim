property :plugin_name, String, name_property: true
property :configuration, String,  default: ''
property :configuration_template, String
property :vim_home, String, default: "#{ENV['HOME']}/.vim"

load_current_value do
  # some Ruby
end

action :install do
     if not ::File.readlines("#{vim_home}/config/vundle.vim").grep("Plugin '#{plugin_name}'").any?
            file = Chef::Util::FileEdit.new("#{vim_home}/config/vundle.vim")
            file.insert_line_after_match(/Plugin 'VundleVim\/Vundle.vim'/, "Plugin '#{plugin_name}'")
            file.write_file

            bash 'run_vim_PluginInstall' do
                 code 'vim +PluginInstall +qall'
            end
            
     end
end 

action :remove do
     if ::File.readlines("#{vim_home}/config/vundle.vim").grep("Plugin '#{plugin_name}'").any?
            file = Chef::Util::FileEdit.new("#{vim_home}/config/vundle.vim")
            search_file_delete_line(/#{plugin_name}/)
            file.write_file
     end
end
