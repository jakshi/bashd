require 'spec_helper'

describe 'bashd cookbook LWRP' do
  context 'in test cookbook' do
    it 'creates /root/.bash.d dir' do
      expect(file '/root/.bash.d').to be_directory
    end
    it 'adds include /root/.bash.d snipplets command to .bashrc' do
      expect(file '/root/.bashrc').to contain 'for include in ~/.bash.d/*.sh; do source ${include} 2>/dev/null; done'
    end
    it 'creates snipplet from template' do
      expect(file '/root/.bash.d/test1.sh').to contain 'export SNIPPET1=\'snippet 1\''
    end
    it 'creates snipplet from content attribute' do
      expect(file '/root/.bash.d/test3.sh').to contain 'export SNIPPET3=\'snippet 3\''
    end
    it 'deletes snipplet' do
      expect(file '/root/.bash.d/test2.sh').not_to be_file      
    end
  end
end
