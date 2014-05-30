require 'spec_helper'

describe Gaku::ImportFile do

  describe 'validations' do
    it { should have_attached_file :data_file }
    it { should validate_presence_of :data_file }
    it { should validate_presence_of :importer_type }

  end

end
