#
# Podfile
#

platform :ios, '11.0'
inhibit_all_warnings!
install! 'cocoapods', integrate_targets: false

def pods

end

target 'CarRecognition' do
    pods
end

target 'CarRecognitionTests' do
    pods
end

plugin 'cocoapods-keys', {
    project: 'CarRecognition',
    keys: [
        'HOCKEYAPP_APP_ID_STAGING',
    ]
}
