# # encoding: utf-8

# Inspec test for recipe miovim::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

if os.debian? 
  describe package('vim') do
    it { should be_installed }
  end
end
if os.redhat?
  describe package('vim-enhanced') do
      it { should be_installed }
  end
end

describe file("/home/vagrant/.vimrc") do
    it { should exist }
#    its('content') { should match(%r{config/vundle.vim}) }
end
#describe file("/home/vagrant/.vim/config/vundle.vim") do
#    it { should exist }
#    its('content') { should match(%r{tpope/vim-fugitive}) }
#end
