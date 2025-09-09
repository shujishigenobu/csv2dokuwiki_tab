#!/usr/bin/env ruby

require_relative "../lib/csv2dokuwiki_tab"
require "optparse"

def parse_options
  options = {}
  header_type = Csv2dokuwikiTab::HEADER_ROW
  OptionParser.new do |opts|
  opts.banner = "Usage: csv_to_dokuwiki_tab.rb [options]\n  (use -f - for STDIN)"

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
    opts.on("-t", "--tab", "Tab-delimited text format (TSV) instead of CSV") do |t|
      options[:tab] = t
    end
    opts.on("-h", "--help", "Prints this help") do
      puts opts
      exit
    end
    opts.on("-v", "--version", "Prints the version") do
      puts Csv2dokuwikiTab::VERSION
      exit
    end
  end.parse!
  unless options[:file]
    warn "Error: CSV file must be specified with -f (use -f - for STDIN)"
    exit 1
  end
#  [options[:file], header_type, options[:tab]]
  return { file: options[:file], header_type: header_type, tab: options[:tab] }
end


#===
# Main CLI

opt = parse_options
p opt
sep = opt[:tab] ? "\t" : ","
converter = Csv2dokuwikiTab::Converter.new(opt[:file], opt[:header_type], sep)
converter.convert

