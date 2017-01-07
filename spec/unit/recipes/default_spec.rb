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

    it 'converges successfully' do
      expect(chef_run).to install_package('vim')
    end
  end
end
