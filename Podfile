# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

# Standard cocoapods specs source
source 'https://cdn.cocoapods.org/'

use_frameworks!
inhibit_all_warnings!

post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings[‘ONLY_ACTIVE_ARCH’] = ‘YES’
      config.build_settings[‘BUILD_LIBRARY_FOR_DISTRIBUTION’] = ‘YES’
      config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'

      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 12.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
      
      xcconfig_path = config.base_configuration_reference.real_path
      xcconfig = File.read(xcconfig_path)
      xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
      File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
    end
  end
end

def test_pods
  pod 'Quick', '~> 7.4'
  pod 'Nimble', :git => 'https://github.com/Quick/Nimble', :tag => 'v13.2.1'
end

# suppress error of duplicate uuids on pod install: https://github.com/ivpusic/react-native-image-crop-picker/issues/680
install! 'cocoapods',
         :deterministic_uuids => false

target 'Client' do
  inherit! :search_paths
  pod 'KarhooUISDK', :path => './'
  pod 'KarhooUISDK/Adyen', :path => './'
  pod 'KarhooUISDK/Braintree', :path => './'

end

# UISDK framework
target 'KarhooUISDK' do
  pod 'KarhooSDK', :git => 'https://github.com/karhoo/karhoo-ios-sdk', :branch => 'master'
#  pod 'KarhooSDK', '1.8.4'
  pod 'SwiftLint', '~> 0.54'
  pod 'SwiftFormat/CLI' , '~> 0.53'
  pod 'BraintreeDropIn', '~> 9.8.1'
  pod 'Braintree/PaymentFlow', '~> 5.20.1'
  pod 'Adyen', '4.7.2'

  target 'KarhooUISDKTests' do
    inherit! :complete
    test_pods
  end

  target 'KarhooUISDKUITests' do
    inherit! :complete
    pod 'SnapshotTesting', '1.9.0'
    test_pods
  end

  target 'KarhooUISDKTestUtils' do
    inherit! :complete
  end
end
