require 'FileUtils' 

puts "Cleaning up..."
# rm_rf "bin/ woodpecker-ios/"

puts "Updating submodules..." 
system "git submodule update --init --recursive"
puts "===================================="

DYLIB_SOURCE_PATH=File.join(Dir.pwd, "/woodpecker-ios/WoodPeckeriOS.xcframework/ios-arm64_armv7/WoodPeckeriOS.framework")

puts "Copying dylib..."
DYLIB_PATH="./WoodPeckerPrefs/layout/Library/Application Support/TSWoodPeckeriOSLoader/WoodPeckeriOS.framework"
Dir.mkdir(DYLIB_PATH) unless File.exist?(DYLIB_PATH)
puts "source: #{DYLIB_SOURCE_PATH}"
puts "destination: #{DYLIB_PATH}"
FileUtils.copy_entry DYLIB_SOURCE_PATH, DYLIB_PATH
puts "============== end copy dylib======================"  

puts "##WARNING: resign WoodPeckeriOS.framework"
#system("codesign -fs 'Apple Distribution: xxxx' #{DYLIB_PATH}")

puts "===================================="

puts "Done."