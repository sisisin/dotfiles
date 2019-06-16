require_relative "vscode_extension_checker"

vec = VscodeExtensionChecker.new
Code.install_extensions(vec.not_installed_list) unless vec.not_installed_list.empty?
