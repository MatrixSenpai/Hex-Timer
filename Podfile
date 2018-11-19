platform :ios, '9.2'

pod 'SwiftyTimer'

target 'Hex Timer' do
  use_frameworks!
  inhibit_all_warnings!

  pod 'ChameleonFramework/Swift', :git => 'https://github.com/ViccAlexander/Chameleon.git', :branch => 'wip/swift4'

  pod 'FontAwesome.swift'
  pod 'Neon'
  pod 'FontBlaster'
  pod 'AFDateHelper', '~> 4.2.2'

end

post_install do | installer |
  require 'fileutils'

  pods_acknowledgements_path = 'Pods/Target Support Files/Pods-Hex Timer/Pods-Hex Timer-Acknowledgements.plist'
  settings_bundle_path = Dir.glob("**/*Settings.bundle*").first

  puts 'Copying acknowledgements to Settings.bundle'
  FileUtils.cp_r(pods_acknowledgements_path, "#{settings_bundle_path}/Acknowledgements.plist", :remove_destination => true)
end
