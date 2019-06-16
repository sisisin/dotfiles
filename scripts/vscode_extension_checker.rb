require "pathname"

module ExtensionFile
  def path
    dotfiles_path = ENV["DOTFILES_PATH"]
    Pathname.new(dotfiles_path).join("vscode/extensions.csv")
  end

  module_function :path
end

module Code
  @code = '/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'

  def list_extensions
    `#{@code} --list-extensions`.split("\n")
  end

  def uninstall_extensions(arg)
    cmd = "--uninstall-extension"
    process_extensions(arg, cmd)
  end

  def install_extensions(arg)
    cmd = "--install-extension"
    process_extensions(arg, cmd)
  end

  private

  def process_extensions(arg, cmd)
    targets = if arg.instance_of? Array
                arg
              elsif arg.instance_of? String
                [arg]
              else
                raise "Argument error."
              end
    targets.each { |target|
      puts `#{@code} #{cmd} #{target}`
    }
    puts "finished `#{cmd}` command."
  end

  module_function :list_extensions, :install_extensions, :uninstall_extensions, :process_extensions
end

class VscodeExtensionChecker
  attr_reader :not_installed_list, :merged_list, :installed_list, :extension_list, :not_written_in_file

  def initialize
    @extension_list = File.open(ExtensionFile.path) { |f| f.read }.split("\n").sort
    @installed_list = Code.list_extensions.sort
    @not_installed_list = extension_list - installed_list
    @not_written_in_file = installed_list - extension_list
    @merged_list = (installed_list + extension_list).uniq.sort
  end

  def should_run_install?
    installed_list.size < extension_list.size
  end
  def should_uninstall?
    installed_list.size > extension_list.size
  end
end
