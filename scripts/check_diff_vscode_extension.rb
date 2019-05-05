require_relative "vscode_extension_checker"

msg = <<-EOS
vscode's extension has diff from dotfiles.
you should run `deploy.sh` or sync commands
EOS

print(msg) if VscodeExtensionChecker.new.should_update?
