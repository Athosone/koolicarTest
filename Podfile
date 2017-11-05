# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

def rx_pod
    pod 'RxSwift'
    pod 'RxCocoa'
end

def test_pods
   rx_pod
   pod 'RxBlocking'
   pod 'Nimble'
end

target 'koolicar' do
  workspace 'koolicar.xcworkspace'
  project 'koolicar.xcodeproj'
  
  use_frameworks! 
  rx_pod
  pod 'Swinject'
  pod 'SwinjectStoryboard'
  pod 'SDWebImage'  
  pod 'Hero'
  target 'koolicarTests' do
    inherit! :search_paths
    test_pods
  end
end

target 'kooliDomain' do
   workspace 'koolicar.xcworkspace'
   project 'kooliDomain/kooliDomain.xcodeproj'
   
   use_frameworks!
   rx_pod
end

target 'kooliInMemPlatform' do
   workspace 'koolicar.xcworkspace'
   project 'kooliInMemPlatform/kooliInMemPlatform.xcodeproj'
   
   use_frameworks!
   rx_pod
   
   target 'kooliInMemPlatformTests' do

   inherit! :search_paths
    test_pods
   end

end