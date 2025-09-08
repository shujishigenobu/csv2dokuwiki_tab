# Csv2dokuwikiTab

Read CSV and convert to DokuWiki table format.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add csv2dokuwiki_tab
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install csv2dokuwiki_tab
```

## Usage

```bash
Usage: csv_to_dokuwiki_tab.rb [options]
    -f, --file FILE                  CSV file to convert
    -d, --header TYPE                Heading type. 1=1st row, 2=1st column, 3=both 1&2, 0=none, default: 1
    -t, --tab                        Tab-delimited text format (TSV) instead of CSV
    -h, --help                       Prints this help
    -v, --version                    Prints the version
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shujishigenobu/csv2dokuwiki_tab
