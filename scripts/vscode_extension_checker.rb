require "pathname"

module ExtensionFile
  def path
    dotfiles_path = ENV["DOTFILES_PATH"]
    Pathname.new(dotfiles_path).join("vscode/extensions.csv")
  end

  module_function :path
end

class VscodeExtensionChecker
  attr_reader :not_installed_list, :should_add_to_list

  def initialize
    extension_list = File.open(ExtensionFile.path) { |f| f.read }.split("\n").sort
    installed_list = `code --list-extensions`.split("\n").sort

    @not_installed_list = extension_list - installed_list
    @should_add_to_list = installed_list - extension_list
  end

  def should_update?
    !(not_installed_list.empty? && should_add_to_list.empty?)
  end
end
