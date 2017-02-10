#
# Cookbook Name:: miovim
# Spec:: plugin
#
# Copyright (c) 2017 The Authors, All Rights Reserved.


require 'spec_helper'


describe 'miovim::plugin' do

    context 'Vundle and plugins are not installed' do
        
        runner = ChefSpec::SoloRunner.new(
            platform: 'ubuntu',
            version: 16.04) do |node|
            node.normal['miovim']['home'] = '/home/mio' 
            node.normal['miovim']['vim']['home'] = "#{node['miovim']['home']}/.vim" 
            node.normal['miovim']['vim']['plugin_list'] = ['tpope/vim-fugitive', 'scrooloose/nerdtree', 'vim-ruby/vim-ruby', 't9md/vim-chef']
        end
        
        before do
            stub_command('grep config/vundle.vim /home/mio/.vimrc').and_return(false)
            allow(File).to receive(:readlines).with('/home/mio/.vim/config/vundle.vim').and_return ['']
        end

        let(:chef_run) do
            runner.converge(described_recipe)
        end

        it 'install vundle' do
            expect(chef_run).to create_directory('/home/mio/.vim/bundle')
            expect(chef_run).to install_package('git')
            expect(chef_run).to sync_git('/home/mio/.vim/bundle/Vundle.vim')
        end
            
        it 'configure vundle' do
            expect(chef_run).to create_directory('/home/mio/.vim/config')
            expect(chef_run).to create_template('/home/mio/.vim/config/vundle.vim')
            expect(chef_run).to run_ruby_block('insert source vundle')
        end

        ['tpope/vim-fugitive', 'scrooloose/nerdtree', 'vim-ruby/vim-ruby', 't9md/vim-chef'].each do |plugin|
            it "install #{plugin} plugin" do
                expect(chef_run).to run_ruby_block("install #{plugin} plugin")
            end
        end
    end

    context 'Vundle and Fugitive are installed' do
        
        runner = ChefSpec::SoloRunner.new(
            platform: 'ubuntu',
            version: 16.04) do |node|
            node.normal['miovim']['home'] = '/home/mio' 
            node.normal['miovim']['vim']['home'] = "#{node['miovim']['home']}/.vim" 
            node.normal['miovim']['vim']['plugin_list'] = ['tpope/vim-fugitive', 'scrooloose/nerdtree', 'vim-ruby/vim-ruby', 't9md/vim-chef']
        end

        before do
            stub_command('grep config/vundle.vim /home/mio/.vimrc').and_return(true)
            allow(File).to receive(:readlines).with('/home/mio/.vim/config/vundle.vim').and_return ["Plugin 'tpope/vim-fugitive'
                                                                                                    Plugin 'tpope/vim-fugitive' 
                                                                                                    Plugin 'scrooloose/nerdtree' 
                                                                                                    Plugin 'vim-ruby/vim-ruby' 
                                                                                                    Plugin 't9md/vim-chef'"]
        end

        let(:chef_run) do
            runner.converge(described_recipe)
        end
        
        it 'do not install and configure vundle and fugitive plugin' do
            expect(chef_run).to_not run_ruby_block('install fugitive plugin')
            expect(chef_run).to_not run_ruby_block('insert source vundle')
        end
    end
end
