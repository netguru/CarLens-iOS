#
# Podfile
#

platform :ios, '11.0'
inhibit_all_warnings!
use_frameworks!


target 'CarLens' do
    pod 'SwiftLint', '~> 0.29.0'

	target 'CarLensTests' do
	    inherit! :search_paths
	end
end

plugin 'cocoapods-keys', {
    project: 'CarLens',
    keys: [
        'HOCKEYAPP_APP_ID_STAGING',	
		'HOCKEYAPP_APP_ID_PRODUCTION'
    ]
}
