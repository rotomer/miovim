#
# Cookbook Name:: miovim
# Spec:: vim
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'miovim::vim' do
    context 'When on ubuntu 16.04 platform' do
        let(:chef_run) do
            runner = ChefSpec::SoloRunner.new(
                platform: 'ubuntu',
                version: '16.04') do |node|
                node.normal['miovim']['home'] = '/home/mio'
            end
        runner.converge(described_recipe)
        end

        it 'installed successfully' do
            expect(chef_run).to install_package('vim')
            expect(chef_run).to create_template('/home/mio/.vimrc')
        end
  end
    context 'When on centos platform' do
        let(:chef_run) do
            runner = ChefSpec::SoloRunner.new(
                platform: 'centos',
                version: 6.3) do |node|
                node.normal['miovim']['home'] = '/home/mio'
            end
            runner.converge(described_recipe)
        end
        it 'installed successfully' do
            expect(chef_run).to install_package('vim-enhanced')
            expect(chef_run).to create_template('/home/mio/.vimrc')
        end
    end
        
end
