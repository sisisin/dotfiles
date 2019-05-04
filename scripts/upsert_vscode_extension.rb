require_relative "vscode_extension_checker"

vec = VscodeExtensionChecker.new

`code --install-extension #{vec.not_installed_list.join(" ")}` unless vec.not_installed_list.empty?

unless vec.should_add_to_list.empty?
  File.open(ExtensionFile.path, "a") do |f|
    vec.should_add_to_list.each { |s| f.puts(s) }
  end
end
