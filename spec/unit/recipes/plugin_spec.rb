#
# Cookbook Name:: miovim
# Spec:: plugin
#
# Copyright (c) 2017 The Authors, All Rights Reserved.


require 'spec_helper'


describe 'miovim::plugin' do
    let(:chef_run) do
        runner = ChefSpec::SoloRunner.new()
        runner.converge(described_recipe)
    end
    it 'vundle installed' do
        expect(chef_run).to create_directory('~/.vim/bundle')
        expect(chef_run).to install_package('git')
        expect(chef_run).to sync_git('~/.vim/bundle/Vundle.vim')
    end
    it 'vundle configured' do
        expect(chef_run).to create_directory('~/.vim/config')
        expect(chef_run).to create_template('~/.vim/config/vundle.vim')
        expect(chef_run).to run_ruby_block('insert source vundle')
    end
end
