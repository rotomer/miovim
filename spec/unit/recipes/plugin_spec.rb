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
        expect(chef_run).to sync_git('vundle')
    end
    it 'vundle configured' do
        expect 
end
