require 'spec_helper'

describe Gaku::Student do

  describe '.as_csv' do
    it 'exports all students to csv' do
      expect(Gaku::Student).to respond_to(:as_csv)
    end
  end

  describe '#as_csv' do
    it 'exports student to csv' do
      student = create(:student)
      expect(student).to respond_to(:as_csv)
    end
  end
end
