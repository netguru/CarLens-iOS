#
# Podfile
#

platform :ios, '11.0'
inhibit_all_warnings!
install! 'cocoapods', integrate_targets: false

def pods

end

target 'CarLens' do
    pods
end

target 'CarLensTests' do
    pods
end

plugin 'cocoapods-keys', {
    project: 'CarLens',
    keys: [
        'HOCKEYAPP_APP_ID_STAGING',	
	'HOCKEYAPP_APP_ID_PRODUCTION'
    ]
}
