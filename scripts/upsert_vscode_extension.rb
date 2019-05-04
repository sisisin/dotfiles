require_relative "vscode_extension_checker"

vec = VscodeExtensionChecker.new

Code.install_extensions(vec.not_installed_list) unless vec.not_installed_list.empty?

unless vec.should_add_to_list.empty?
  File.open(ExtensionFile.path, "a") do |f|
    vec.should_add_to_list.each { |s| f.puts(s) }
  end
end
