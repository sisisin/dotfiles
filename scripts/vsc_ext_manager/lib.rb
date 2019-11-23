# frozen_string_literal: true

require 'pathname'

module ExtensionFile
  def path
    dotfiles_path = ENV['DOTFILES_PATH']
    Pathname.new(dotfiles_path).join('vscode/extensions.csv')
  end

  module_function :path
end

module Code
  @code = '/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'

  def list_extensions
    `#{@code} --list-extensions`.split("\n")
  end

  def uninstall_extensions(arg)
    cmd = '--uninstall-extension'
    process_extensions(arg, cmd)
  end

  def install_extensions(arg)
    cmd = '--install-extension'
    process_extensions(arg, cmd)
  end

  private

  def process_extensions(arg, cmd)
    targets = if arg.instance_of? Array
                arg
              elsif arg.instance_of? String
                [arg]
              else
                raise 'Argument error.'
              end
    targets.each do |target|
      puts `#{@code} #{cmd} #{target}`
    end
    puts "finished `#{cmd}` command."
  end

  module_function :list_extensions, :install_extensions, :uninstall_extensions, :process_extensions
end

class VscodeExtensionChecker
  attr_reader :not_installed_list, :merged_list, :installed_list, :extension_list, :not_written_in_file

  def initialize
    @extension_list = File.open(ExtensionFile.path, &:read).split("\n").sort
    @installed_list = Code.list_extensions.sort
    @not_installed_list = extension_list - installed_list
    @not_written_in_file = installed_list - extension_list
    @merged_list = (installed_list + extension_list).uniq.sort
  end
end

class VscodeExtManager
  def initialize
    @vec = VscodeExtensionChecker.new
  end
  def process(arg, _opts)
    case arg
    when :"check-diff"
      check_diff
    when :install
      install
    when :uninstall
      uninstall
    when :overwrite
      overwrite
    when :"install-and-append-to-file"
      install_and_append_to_file
    end
  end

  private

  def install_and_append_to_file

    Code.install_extensions(@vec.not_installed_list) unless @vec.not_installed_list.empty?

    # Write fresh list everytime, because list order shouldn't be changed
    File.open(ExtensionFile.path, 'w') do |f|
      @vec.merged_list.each { |s| f.puts(s) }
    end
  end

  def overwrite
    File.open(ExtensionFile.path, 'w') do |f|
      VscodeExtensionChecker.new.installed_list.each { |ext| f.puts ext }
    end
  end

  def install
    Code.install_extensions(@vec.not_installed_list) unless @vec.not_installed_list.empty?
  end

  def uninstall
    Code.uninstall_extensions(@vec.not_written_in_file)
  end

  def check_diff
    unless @vec.not_written_in_file.empty? && @vec.not_installed_list.empty?
      print "Following list is difference between vscode and ext master file.\n\n"

      reset_es = "\e[0m"
      bold_es = "\e[1m"

      unless @vec.not_written_in_file.empty?
        plus_es = "\e[93m"
        print "Installed in vscode.\n"
        print plus_es
        print @vec.not_written_in_file.map { |item| "+ #{item}" }.join("\n")
        print "#{reset_es}\n\n"
      end

      unless @vec.not_installed_list.empty?
        minus_es = "\e[31m"
        print "#{bold_es}NOT#{reset_es} installed in vscode.\n"
        print minus_es
        print @vec.not_installed_list.map { |item| "- #{item}" }.join("\n")
        print "#{reset_es}\n\n"
      end

      msg = <<~EOS
        you should update vscode's ext installation or ext list file.
        run...

        - vsc-ext-manager install                     install exts from master file
        - vsc-ext-manager uninstall                   uninstall exts which is not exists master file
        - vsc-ext-manager overwrite                   overwrite exts which is already installed to master file
        - vsc-ext-manager install-and-append-to-file  install and overwrite
      EOS

      print msg
    end
  end
end
