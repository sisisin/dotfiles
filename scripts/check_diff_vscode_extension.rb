require_relative "vscode_extension_checker"
vec = VscodeExtensionChecker.new
msg = <<-EOS
you should uninstall vscode's extensions.
EOS

print(msg) if vec.should_uninstall?

should_install_msg = <<-EOS
you should install vscode's extensions.
run `install-vscode-extensions` command
EOS
print(msg) if vec.should_run_install?
