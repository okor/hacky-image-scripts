# Take an input gif and fill the transparency in the first frame with a specified color.
# Depends on: imagemagick, gifsicle


in_file = ARGV[0]
out_file = ARGV[1]
bg_color = ARGV[2]

if !in_file || !out_file || !bg_color
  puts "must specify input file, output file and background fill color"
  puts "Example: ruby fill_transparency_with_color.rb 5_rapid_fire.gif fixed/5_rapid_fire-noalpha.gif \"#e7e7e2\""
  exit
end

tmp_dir = "#{Time.now.to_i.to_s}"
Dir.mkdir "#{tmp_dir}"

`cp #{in_file} #{tmp_dir}/#{in_file.split('/').last}`
`cd #{tmp_dir} && gifsicle --explode #{in_file}`


frames = Dir.glob("#{tmp_dir}/*\.gif\.*")
`convert #{frames[0]} -background "#{bg_color}" -flatten #{frames[0]}`
`gifsicle #{frames.join(' ')} > #{out_file}`

`rm -R #{tmp_dir}`
