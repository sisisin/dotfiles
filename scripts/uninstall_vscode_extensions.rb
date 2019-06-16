require_relative "vscode_extension_checker"

vec = VscodeExtensionChecker.new
Code.uninstall_extensions(vec.not_written_in_file)
