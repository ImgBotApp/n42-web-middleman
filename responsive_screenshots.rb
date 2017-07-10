require 'optparse'
require 'ostruct'
require 'date'

options = OpenStruct.new

options.update = false

OptionParser.new do |opts|
  opts.banner = "Usage: responsive_screenshot.rb [base-url] [subpages] \nExample: responsive_screenshot.rb http://192.168.1.36:4567/ anfahrt.html cookie_richtlinie.html datenschutz.html impressum.html jobs.html"
  opts.on_tail("-h", "--help", "Show this message") do
      puts opts
      exit
  end
end.parse!

if options.update
  puts "updating"
  exec("curl -L #{scriptSource}?$(date +%s) -o #{File.basename($0)}")
end


url = ARGV[0]
subpages = []

$i = 1
$num = ARGV.length

while $i < $num  do
   subpages.push(ARGV[$i])
   $i +=1
end

widths = {:w320_iPhone_5_portrait => 320,
          :w586_iPhone_5_landscape => 586,
          :w375_iPhone_6_portrait => 375,
          :w667_iPhone_6_landscape => 667,
          :w786_iPad_portrait => 786,
          :w1024_iPad_landscape => 1024,
          :w834_iPad_Pro_portrait => 834,
          :w1112_iPad_Pro_landscape => 1112,
          :w1024_iPad_Pro_13_portrait => 1024,
          :w1366_iPad_Pro_13_landscape => 1366,
          :w1920_Web => 1920,
          :w1366_Web => 1366}

$timestamp = DateTime.now.strftime("%Y-%d-%m-") + Time.now.to_i.to_s

if ARGV.empty?
  puts "Missing arguments. See: ruby responsive_screenshots.rb --help"
else
  for device in widths.keys
    if subpages
      for page in subpages
        system("webkit2png -W #{widths[device]} --scale=1 -F --dir=responsive_screenshots/#{$timestamp}/#{page}/ --filename=#{device} #{url}#{page}")
      end
    end
    system("webkit2png -W #{widths[device]} --scale=1 -F --dir=responsive_screenshots/#{$timestamp} --filename=#{device} #{url}")
  end
end
