require_relative "../lib/csv2dokuwiki_tab"
require "optparse"

def parse_options
  options = {}
  header_type = Csv2dokuwikiTab::HEADER_ROW
  OptionParser.new do |opts|
    opts.banner = "Usage: csv_to_dokuwiki_tab.rb [options]"

    opts.on("-f FILE", "--file FILE", "CSV file to convert") do |f|
      options[:file] = f
    end
    opts.on("-d TYPE", "--header TYPE", "Heading type. 1=1st row, 2=1st column, 3=both 1&2, 0=none, default: 1") do |d|
      case d
      when "1"
        header_type = Csv2dokuwikiTab::HEADER_ROW
      when "2"
        header_type = Csv2dokuwikiTab::HEADER_COL
      when "3"
        header_type = Csv2dokuwikiTab::HEADER_BOTH
      when "0"
        header_type = Csv2dokuwikiTab::HEADER_NONE
      else
        warn "Unknown header type '#{d}', using default."
        header_type = Csv2dokuwikiTab::HEADER_ROW
      end
    end
    opts.on("-h", "--help", "Prints this help") do
      puts opts
      exit
    end
  end.parse!
  unless options[:file]
    warn "Error: CSV file must be specified with -f"
    exit 1
  end
  [options[:file], header_type]
end


#===
# Main CLI

file, header_type = parse_options
converter = Csv2dokuwikiTab::Converter.new(file, header_type)
converter.convert

