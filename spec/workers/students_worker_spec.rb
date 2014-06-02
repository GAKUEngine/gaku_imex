require 'spec_helper'

describe Gaku::Importers::StudentsWorker do

  it 'adds new job' do
    expect { described_class.perform_async('file_path') }.to change(described_class.jobs, :size).by(1)
  end

end
