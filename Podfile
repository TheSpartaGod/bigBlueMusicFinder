# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'

target 'MusicFinder' do
  use_frameworks!
  pod 'Alamofire'

  target 'MusicFinderTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MusicFinderUITests' do
    # Pods for testing
  end

end

# force targets to use ios 13 miniimum deployment
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
