require "pathname"

module ExtensionFile
  def path
    dotfiles_path = ENV["DOTFILES_PATH"]
    Pathname.new(dotfiles_path).join("vscode/extensions.csv")
  end

  module_function :path
end

module Code
  @cmd = '/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'

  def list_extensions
    `#{@cmd} --list-extensions`.split("\n")
  end

  def install_extensions(arg)
    targets = if arg.instance_of? Array
                arg
              elsif arg.instance_of? String
                [arg]
              else
                raise "Argument error."
              end
    targets.each { |target|
      puts `#{@cmd} --install-extension #{target}`
    }
    puts "finished installing extensions"
  end

  module_function :list_extensions, :install_extensions
end

class VscodeExtensionChecker
  attr_reader :not_installed_list, :merged_list, :installed_list, :extension_list

  def initialize
    @extension_list = File.open(ExtensionFile.path) { |f| f.read }.split("\n").sort
    @installed_list = Code.list_extensions.sort
    @not_installed_list = extension_list - installed_list
    @merged_list = (installed_list + extension_list).uniq.sort
  end

  def should_update?
    installed_list.size != extension_list.size
  end
end
