# frozen_string_literal: true

RSpec.describe Csv2dokuwikiTab do
  let(:csv_file) { "spec/test.csv" }

  before do
    File.write(csv_file, "Name,Age,Country\nAlice,30,USA\nBob,25,Canada\n")
  end

  after do
    File.delete(csv_file) if File.exist?(csv_file)
  end

  it "has a version number" do
    expect(Csv2dokuwikiTab::VERSION).not_to be nil
  end

  it 'converts CSV with header row to DokuWiki table format' do
    output = StringIO.new
    $stdout = output
    table = Csv2dokuwikiTab::Converter.new(csv_file, Csv2dokuwikiTab::HEADER_ROW)
    table.convert
    $stdout = STDOUT
    expect(output.string).to include('^ Name ^ Age ^ Country ^')
    expect(output.string).to include('| Alice | 30 | USA |')
    expect(output.string).to include('| Bob | 25 | Canada |')
  end

  it 'converts CSV with no header to DokuWiki table format' do
    output = StringIO.new
    $stdout = output
    table = Csv2dokuwikiTab::Converter.new(csv_file, Csv2dokuwikiTab::HEADER_NONE)
    table.convert
    $stdout = STDOUT
    expect(output.string).not_to include('^ Name ^ Age ^ Country ^')
    expect(output.string).to include('| Name | Age | Country |')
    expect(output.string).to include('| Alice | 30 | USA |')
    expect(output.string).to include('| Bob | 25 | Canada |')
  end

  it 'converts TSV with tab separator to DokuWiki table format' do
    tsv_file = "spec/test.tsv"
    File.write(tsv_file, "Name\tAge\tCountry\nAlice\t30\tUSA\nBob\t25\tCanada\n")
    output = StringIO.new
    $stdout = output
    table = Csv2dokuwikiTab::Converter.new(tsv_file, Csv2dokuwikiTab::HEADER_ROW, "\t")
    table.convert
    $stdout = STDOUT
    expect(output.string).to include('^ Name ^ Age ^ Country ^')
    expect(output.string).to include('| Alice | 30 | USA |')
    expect(output.string).to include('| Bob | 25 | Canada |')
    File.delete(tsv_file) if File.exist?(tsv_file)
  end


end