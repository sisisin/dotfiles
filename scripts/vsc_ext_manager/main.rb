# frozen_string_literal: true

require_relative './lib'
require 'optparse'

class Main
  def run
    opts = {}
    OptionParser.new do |parser|
      parser.banner = 'Usage: vsc_ext_manager [args]'
      parser.on('-d', '--dry-run', 'Dry run')
      parser.on_tail('-h', '--help', 'Prints this help') do
        puts parser
        exit
      end
    end.parse!(into: opts)
    sub_cmd = parse_sub_cmd
    VscodeExtManager.new.process(sub_cmd, opts)
  end

  private

  def parse_sub_cmd
    arg = ARGV.first

    valid_cmds = %w[check-diff
                    install
                    uninstall
                    overwrite
                    install-and-append-to-file]

    unless valid_cmds.include?(arg)
      print "invalid argument `#{arg}`. you must specify following args\n"
      print valid_cmds.map { |c| "- #{c}" }.join("\n")
      print "\n"
      exit 1
    end

    arg.to_sym
  end
end
