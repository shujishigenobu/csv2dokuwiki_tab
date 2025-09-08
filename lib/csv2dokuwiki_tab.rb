# frozen_string_literal: true

require_relative "csv2dokuwiki_tab/version"


############################
# csv_to_dokuwiki_tab.rb
#
# Read CSV and convert to DokuWiki table format
# Dokuwiki syntax is described here: https://www.dokuwiki.org/wiki:syntax#tables
############################

module Csv2dokuwikiTab
  class Error < StandardError; end
  # Your code goes here...

  require "csv"

  HEADER_NONE = 0
  HEADER_ROW = 1
  HEADER_COL = 2
  HEADER_BOTH = 3

  class Converter
    def initialize(file, header_type=1, sep=",")
      @file = file
      @header_type = header_type
      @sep = sep
    end

    def convert
      begin
        CSV.foreach(@file, col_sep: @sep).with_index do |row, idx|
          next if row.all? { |x| x.nil? }
          if idx == 0
            print_header_row(row)
          else
            print_data_row(row)
          end
        end
      rescue Errno::ENOENT
        warn "Error: File not found: #{@file}"
        exit 1
      rescue CSV::MalformedCSVError => e
        warn "Error: Malformed CSV - #{e.message}"
        exit 1
      end
    end

    private

    def print_header_row(row)
      case @header_type
      when HEADER_ROW, HEADER_BOTH
        puts "^" + row.map { |x| " #{x} " }.join("^") + "^"
      else
        puts "|" + row.map { |x| " #{x} " }.join("|") + "|"
      end
    end

    def print_data_row(row)
      case @header_type
      when HEADER_COL, HEADER_BOTH
        puts "^" + row[0].to_s + "^" + row[1..-1].map { |x| " #{x} " }.join("|") + "|"
      else
        puts "|" + row.map { |x| " #{x} " }.join("|") + "|"
      end
    end
  end

end
