require 'fileutils'

patches = {}
files = {}

last = ""
crack = ""
filename = ""
File.readlines(ARGV[0]).each do |line|
  line.strip!
  match = /(?<addr>[0-9a-fA-F]{8}): (?<o>[0-9a-fA-F]{2}) (?<n>[0-9a-fA-F]{2})/.match(line)
  if match then
    raise if crack.empty? or filename.empty?
    patches[crack] = {} if patches[crack] == nil
    files[crack] = filename
    patches[crack][match["addr"]] = [match["o"], match["n"]]
  else
    if line.strip.empty? then
      crack = ""
    else
      filename = line if not crack.empty?
      crack = line if last.empty?
    end
  end
  last = line
end

puts "Available patches:"
patches.each do |crack, patch|
  puts "- %s" % crack
end

puts "", "Which patches do you want to apply?"
copied = {}
patches.each do |crack, patch|
  puts "", "%s (%s) - Patch? (Y/n) " % [crack, files[crack]]
  ans = STDIN.gets.downcase.strip
  ans = "y" if ans.empty?

  if ans == "y" then 
    filename = files[crack]
    patched = filename.chomp(File.extname(filename)) + "_patched" + File.extname(filename)
    if copied[filename] == nil then
       FileUtils.copy_file filename, patched
       FileUtils.chmod "a=wr", patched
       copied[filename] = true
       puts "Created the patched file %s" % patched
    end
    patch.each do |addr, values|
      addr = addr.to_i(16)
      ch = IO.binread(patched, 1, addr)[0].ord
      if ch != values[0].to_i(16) then
        raise "Failed to patch, value at %08X must be %s but %02X found" % [addr, values[0], ch]
      end
      IO.binwrite(patched, values[1].to_i(16).chr, addr)
      ch = IO.binread(patched, 1, addr)[0].ord
      if ch != values[1].to_i(16) then
        raise "Failed to verify, value at %08X must be %s but %02X found" % [addr, values[1], ch]
      end
    end
    puts "Patched"
  end
end
