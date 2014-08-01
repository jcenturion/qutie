require 'rake'
require 'fileutils'

desc "Hook our dotfiles into system-standard positions."
task :install => [ :welcome, :install_homebrew, :install_vundle, :install_prezto, :install_nvm, :install_jenv, :install_fonts, :install_chrome_custom_css, :install_textmate_preferences, :install_osx_defaults, :install_osx_utils, :color_scheme ] do
  success_msg("installed")
end

task :update => [ :welcome, :update_osx_utils ] do
  success_msg("updated")
end

task :color_scheme => [ :welcome ] do
  unless File.exists?(File.join(ENV['HOME'], ".base16"))
    puts "\033[34m===> \033[0mCloning Base16 Builder repository..."
    %x[mkdir -p $HOME/.base16]
    %x[git clone git@github.com:chriskempson/base16-builder.git $HOME/.base16]
  end

  puts "\033[34m===> \033[0mBuilding color schemes..."
  %x[cp -Rf $HOME/.qutie/base16/iterm2-bookmarks $HOME/.base16/templates]
  %x[cp -Rf $HOME/.qutie/base16/terminal-app $HOME/.base16/templates]
  %x[cd $HOME/.base16; ./base16]
  puts "--------------------------------------------------------------------------"

  schemes = Dir.glob(File.join(ENV['HOME'], "/.base16/schemes/*.yml"))
  i = 0
  schemes.each do |scheme|
    i = i + 1
    name = File.basename(scheme, ".yml").capitalize.gsub('-', '')
    puts "\033[34m#{i} > \033[0m#{name}"
  end
  puts "--------------------------------------------------------------------------"
=begin
  selected_theme = -1
  while selected_theme == -1
    puts "Which theme would you like? "
    selected_theme = STDIN.gets.chomp.to_i
    if selected_theme > schemes.size or selected_theme < 1
      puts "\033[31mInvalid theme number\033[0m"
      selected_theme = -1
    end
  end
  puts "--------------------------------------------------------------------------"
  selected_theme_name = File.basename(schemes[selected_theme - 1], ".yml")
  puts "Updating your applications to match the selected theme \033[33m#{selected_theme_name.capitalize}\033[0m"
  puts "--------------------------------------------------------------------------"
=end

  puts "\033[34m===> \033[0mUpdating the color scheme for iTerm 2..."
  %x[/usr/bin/defaults delete com.googlecode.iterm2 'Custom Color Presets']
  schemes.each do |scheme|
    i = i + 1
    name = File.basename(scheme, ".yml").gsub('-', '')
    [ 'dark', 'light' ].each do |dl|
      content = File.read(File.join(ENV['HOME'], '.base16/output/iterm2/base16-' + name + '.' + dl + '.256.itermcolors'))
      content.sub! '<?xml version="1.0" encoding="UTF-8"?>', ''
      content.sub! '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">', ''
      content.sub! '<plist version="1.0">', ''
      content.sub! '</plist>', ''
      %x[/usr/bin/defaults write com.googlecode.iterm2 'Custom Color Presets' -dict-add 'Base16 #{name.capitalize} #{dl.capitalize} 256'  '#{content}']

      content = File.read(File.join(ENV['HOME'], '.base16/output/iterm2/base16-' + name + '.' + dl + '.itermcolors'))
      content.sub! '<?xml version="1.0" encoding="UTF-8"?>', ''
      content.sub! '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">', ''
      content.sub! '<plist version="1.0">', ''
      content.sub! '</plist>', ''
      %x[/usr/bin/defaults write com.googlecode.iterm2 'Custom Color Presets' -dict-add 'Base16 #{name.capitalize} #{dl.capitalize}'  '#{content}']
    end
  end

  %x[/usr/bin/defaults delete com.googlecode.iterm2 'New Bookmarks']
  schemes.each do |scheme|
    i = i + 1
    name = File.basename(scheme, ".yml").gsub('-', '')
    [ 'dark', 'light' ].each do |dl|
      content = File.read(File.join(ENV['HOME'], '.base16/output/iterm2-bookmarks/base16-' + name + '.' + dl + '.256.itermbookmark'))
      content.sub! '<?xml version="1.0" encoding="UTF-8"?>', ''
      content.sub! '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">', ''
      content.sub! '<plist version="1.0">', ''
      content.sub! '</plist>', ''
      %x[/usr/bin/defaults write com.googlecode.iterm2 'New Bookmarks' -array-add '#{content}']

      content = File.read(File.join(ENV['HOME'], '.base16/output/iterm2-bookmarks/base16-' + name + '.' + dl + '.itermbookmark'))
      content.sub! '<?xml version="1.0" encoding="UTF-8"?>', ''
      content.sub! '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">', ''
      content.sub! '<plist version="1.0">', ''
      content.sub! '</plist>', ''
      %x[/usr/bin/defaults write com.googlecode.iterm2 'New Bookmarks' -array-add '#{content}']
    end
  end

  puts "\033[34m===> \033[0mUpdating the color scheme for Apple Terminal..."
  %x[/usr/bin/defaults delete com.apple.Terminal 'Window Settings']
  schemes.each do |scheme|
    i = i + 1
    name = File.basename(scheme, ".yml").gsub('-', '')
    [ 'light', 'dark' ].each do |dl|
      content = File.read(File.join(ENV['HOME'], '.base16/output/terminal-app/base16-' + name + '.' + dl + '.256.terminal'))
      content.sub! '<?xml version="1.0" encoding="UTF-8"?>', ''
      content.sub! '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">', ''
      content.sub! '<plist version="1.0">', ''
      content.sub! '</plist>', ''
      %x[/usr/bin/defaults write com.apple.Terminal 'Window Settings' -dict-add 'Base16 #{scheme.capitalize} #{dl.capitalize} 256' '#{content}']

      content = File.read(File.join(ENV['HOME'], '.base16/output/terminal-app/base16-' + name + '.' + dl + '.terminal'))
      content.sub! '<?xml version="1.0" encoding="UTF-8"?>', ''
      content.sub! '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">', ''
      content.sub! '<plist version="1.0">', ''
      content.sub! '</plist>', ''
      %x[/usr/bin/defaults write com.apple.Terminal 'Window Settings' -dict-add 'Base16 #{scheme.capitalize} #{dl.capitalize}' '#{content}']
    end
  end

  if File.exists?('/Applications/TextMate.app')
    puts "\033[34m===> \033[0mUpdating the color scheme for TextMate 2..."
    %x[rm -Rf "$HOME/Library/Application Support/Avian/Bundles/Base16.tmbundle"]
    %x[mkdir -p "$HOME/Library/Application Support/Avian/Bundles/"]
    %x[cp -R $HOME/.qutie/textmate/Base16.tmbundle "$HOME/Library/Application Support/Avian/Bundles/"]
    %x[mkdir -p "$HOME/Library/Application Support/Avian/Bundles/Base16.tmbundle/Themes"]
    %x[cp $HOME/.base16/output/textmate/*.tmTheme "$HOME/Library/Application Support/Avian/Bundles/Base16.tmBundle/Themes"]
    %x[rm -Rf ~/Library/Caches/com.macromates.TextMate]
    %x[rm -Rf ~/Library/Caches/com.macromates.TextMate.preview]
  end

  %x[killall cfprefsd]
end

task :welcome do
  puts "\033[33m   ____        __  _"
  puts "\033[33m  / __ \\__  __/ /_(_)__     \033[37mqut.ie"
  puts "\033[33m / / / / / / / __/ / _ \\    \033[31m/'kyoote/"
  puts "\033[33m/ /_/ / /_/ / /_/ /  __/    \033[32mNoun"
  puts "\033[33m\\___\\_\\__,_/\\__/_/\\___/     \033[0mAn attractive or endearing shell."
  puts "--------------------------------------------------------------------------"
  puts "Copyright (C) 2013 Emiliano Lesende."
  puts "Based on YADR. Copyright (c) 2011-2012, Yan Pritzker. All rights reserved."
  puts "--------------------------------------------------------------------------\033[0m"
end

task :install_osx_utils do
  puts "\033[34m===> \033[0mInstalling miscelaneous OSX utils like trash, pbcopy, eject, etc..."
  unless File.exists?(File.join(ENV['HOME'], ".tools-osx"))
    %x[mkdir -p $HOME/.tools-osx]
    %x[git clone git@github.com:morgant/tools-osx.git $HOME/.tools-osx]
  end

  %x[cp -Rf $HOME/.qutie/zsh/modules/tools-osx $HOME/.zprezto/modules]
end

task :update_osx_utils do
  puts "\033[34m===> \033[0mUpdating miscelaneous OSX utils like trash, pbcopy, eject, etc..."
  %x[cd $HOME/.tools-osx; git pull origin master]
end

task :install_osx_defaults do
  puts "\033[34m===> \033[0mDisabling menu bar transparency..."
  %x[defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false]

  puts "\033[34m===> \033[0mCustomizing battery indicator..."
  %x[defaults write com.apple.menuextra.battery ShowPercent -string "NO"]
  %x[defaults write com.apple.menuextra.battery ShowTime -string "YES"end]

  puts "\033[34m===> \033[0mEnabling expanded save panel by default..."
  %x[defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true]

  puts "\033[34m===> \033[0mDisabling the \"Are you sure you want to open this application?\" dialog..."
  %x[defaults write com.apple.LaunchServices LSQuarantine -bool false]

  puts "\033[34m===> \033[0mEnabling subpixel font rendering on non-Apple LCDs..."
  %x[defaults write NSGlobalDomain AppleFontSmoothing -int 2]

  puts "\033[34m===> \033[0mDisabling press-and-hold for keys in favor of key repeat..."
  %x[defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false]

  puts "\033[34m===> \033[0mDisabling auto-correct..."
  %x[defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false]

  puts "\033[34m===> \033[0mRequiring password immediately after sleep or screen saver begins..."
  %x[defaults write com.apple.screensaver askForPassword -int 1]
  %x[defaults write com.apple.screensaver askForPasswordDelay -int 0]

  puts "\033[34m===> \033[0mDisabling disk image verification..."
  %x[defaults write com.apple.frameworks.diskimages skip-verify -bool true]
  %x[defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true]
  %x[defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true]

  puts "\033[34m===> \033[0mAvoiding creating .DS_Store files on network volumes..."
  %x[defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true]

  puts "\033[34m===> \033[0mDisable warning when changing file extension..."
  %x[defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false]

  puts "\033[34m===> \033[0mEnabling spring loading for all Dock items..."
  %x[defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true]

  puts "\033[34m===> \033[0mEnabling iTunes track notifications in the Dock..."
  %x[defaults write com.apple.dock itunes-notifications -bool true]

  puts "\033[34m===> \033[0mDisabling shadow in screenshots..."
  %x[defaults write com.apple.screencapture disable-shadow -bool true]

  puts "\033[34m===> \033[0mRestarting affected applications..."
  %x[for app in Finder Dock Mail Safari iTunes iCal Address\ Book SystemUIServer; do killall "$app" > /dev/null 2>&1; done]
end

task :install_nvm do
  puts "\033[34m===> \033[0mInstalling Node Version Manager (NVM)..."

  unless File.exists?(File.join(ENV['HOME'], ".nvm"))
    %x[git clone https://github.com/creationix/nvm.git $HOME/.nvm]
  end
end

task :default => 'install'

task :install_homebrew do
  %x[which brew]
  unless $?.success?
    puts "\033[34m===> \033[0mInstalling Homebrew, the OSX package manager... If it's already installed, this will do nothing."
    %x[ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"]
  end

  puts
  puts
  puts "\033[34m===> \033[0mUpdating Homebrew."
  %x[brew update]
  puts
  puts
  puts "\033[34m===> \033[0mInstalling Homebrew packages...There may be some warnings."
  %x[brew install zsh ctags git hub tmux reattach-to-user-namespace coreutils]
  puts
  puts
end

task :install_fonts do
  puts "\033[34m===> \033[0mInstalling patched fonts for Powerline..."
  %x[cp -f $HOME/.qutie/fonts/* $HOME/Library/Fonts]
end

task :install_textmate_preferences do
  if File.exists?('/Applications/TextMate.app')
    puts "\033[34m===> \033[0mCustomizing preferences of TextMate 2..."
    %x[cp -f $HOME/.qutie/textmate/tm_properties "$HOME/.tm_properties"]
  end
end

task :install_jenv do
  puts "\033[34m===> \033[0mInstalling jEnv (Java Version Manager)..."
  unless File.exists?(File.join(ENV['HOME'], ".jenv"))
    %x[git clone https://github.com/gcuisinier/jenv.git ~/.jenv]
  end

  puts "\033[34m===> \033[0mInstalling Prezto jEnv module..."
  %x[cp -Rf $HOME/.qutie/zsh/modules/jenv $HOME/.zprezto/modules]

  puts "\033[34m===> \033[0mAdding default JDK..."
  if File.exists?("/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home")
    %x[$HOME/.jenv/bin/jenv add /System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home]
  end

  Dir.glob("/Library/Java/JavaVirtualMachines/*") do |f|
    puts "\033[34m===> \033[0mAdding JDK located at #{f}..."
    %x[$HOME/.jenv/bin/jenv add #{f}/Contents/Home]
  end
end

task :install_prezto do
  puts "\033[34m===> \033[0mInstalling Prezto (ZSH Enhancements)..."
  unless File.exists?(File.join(ENV['ZDOTDIR'] || ENV['HOME'], ".zprezto"))
    %x[/bin/zsh -c 'git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"']
  end
  %x[/bin/zsh -c 'setopt EXTENDED_GLOB; for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"; done']
  %x[rm -f $HOME/.zpreztorc]
  %x[cp -f $HOME/.qutie/zsh/zpreztorc $HOME/.zpreztorc]

  %x[cp -Rf $HOME/.qutie/zsh/modules/base16 $HOME/.zprezto/modules]

  if ENV["SHELL"].include? 'zsh' then
    puts "\033[31m===> \033[0mZsh is already configured as your shell of choice. Restart your session to load the new settings"
  else
    puts "\033[34m===> \033[0mSetting zsh as your default shell..."
    %x[chsh -s /bin/zsh]
  end

  puts "\033[34m===> \033[0mInstalling Powerline prompt for ZSH..."
  %x[cp -f $HOME/.qutie/zsh/prompt-powerline $HOME/.zprezto/modules/prompt/functions/prompt_powerline_setup]
end

def want_to_install? (section)
  if ENV["ASK"]=="true"
    puts "Would you like to install configuration files for: #{section}? [y]es, [n]o"
    STDIN.gets.chomp == 'y'
  else
    true
  end
end

def success_msg(action)
  puts "--------------------------------------------------------------------------"
  puts "\033[33mQutie\033[0m has been \033[37m#{action}\033[0m."
  puts "Please restart your terminal and vim."
end
