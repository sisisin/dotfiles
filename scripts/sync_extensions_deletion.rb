require_relative "vscode_extension_checker"

File.open(ExtensionFile.path, "w") do |f|
  VscodeExtensionChecker.new.installed_list.each { |ext| f.puts ext }
end
