# Uncomment this line to define a global platform for your project
platform :ios, '9.2'

target 'Hex Timer' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

<<<<<<< HEAD
  pod 'MMDrawerController'
  pod 'FontAwesome.swift'
  pod 'Neon'
  pod 'ChameleonFramework/Swift'
  pod 'SwiftyTimer'
  pod 'AFDateHelper'
  pod 'SwiftFontName'

end

post_install do | installer |
  require 'fileutils'

  pods_acknowledgements_path = 'Pods/Target Support Files/Pods-Hex Timer/Pods-Hex Timer-Acknowledgements.plist'
  settings_bundle_path = Dir.glob("**/*Settings.bundle*").first

  puts 'Copying acknowledgements to Settings.bundle'
  FileUtils.cp_r(pods_acknowledgements_path, "#{settings_bundle_path}/Acknowledgements.plist", :remove_destination => true)
=======
  pod 'Neon'
  pod 'MMDrawerController'
  pod 'FontAwesome.swift'
>>>>>>> 035d62cbcf2c0c85a77ed611ec8c4a109d7d7678
end
