#
# Cookbook Name:: miovim
# Spec:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'miovim::default' do
    context 'When all attributes are default, on ubuntu 16.04 platform' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(
          platform: 'ubuntu',
          version: 16.04 )
      runner.converge(described_recipe)
    end

    it 'installed successfully' do
      expect(chef_run).to install_package('vim')
    end
  end
    context 'When all attributes are default, on centos platform' do
        let(:chef_run) do
            runner = ChefSpec::SoloRunner.new(
                platform: 'centos',
                version: 6.3)
            runner.converge(described_recipe)
        end
        it 'installed successfully' do
            expect(chef_run).to install_package('vim-enhanced')
        end
    end
        
end
