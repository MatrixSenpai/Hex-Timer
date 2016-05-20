platform :ios, '9.2'
use_frameworks!

pod 'SwiftyTimer'

target 'Hex Timer' do
  use_frameworks!

  pod 'MMDrawerController'
  pod 'FontAwesome.swift'
  pod 'Neon'
  pod 'ChameleonFramework/Swift'
  pod 'AFDateHelper'
  pod 'SwiftFontName'

end

target 'Hex Watch Timer' do
  platform :watchos, '2.0'
end

post_install do | installer |
  require 'fileutils'

  pods_acknowledgements_path = 'Pods/Target Support Files/Pods-Hex Timer/Pods-Hex Timer-Acknowledgements.plist'
  settings_bundle_path = Dir.glob("**/*Settings.bundle*").first

  puts 'Copying acknowledgements to Settings.bundle'
  FileUtils.cp_r(pods_acknowledgements_path, "#{settings_bundle_path}/Acknowledgements.plist", :remove_destination => true)
end
