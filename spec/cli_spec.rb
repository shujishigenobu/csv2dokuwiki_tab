
require 'open3'
require 'shellwords'

RSpec.describe 'csv2dokuwiki_tab CLI' do
  let(:exe_path) { Shellwords.escape(File.expand_path('../../exe/csv2dokuwiki_tab.rb', __FILE__)) }
  let(:sample_csv) { Shellwords.escape(File.expand_path('../examples/example.csv', __dir__)) }

  it 'shows help message with --help' do
    stdout, stderr, status = Open3.capture3("ruby #{exe_path} --help")
    expect(stdout).to include('Usage')
    expect(status.success?).to be true
  end

  it 'converts CSV to dokuwiki table' do
    expected_output = File.read(File.expand_path('../examples/example.csv.convert_def.txt', __dir__))
    stdout, stderr, status = Open3.capture3("ruby #{exe_path} -f #{sample_csv}")
    expect(stdout.strip).to eq(expected_output.strip)
    expect(status.success?).to be true
  end
end
