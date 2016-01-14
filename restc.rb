#!/usr/bin/env ruby

require 'rest-client'
require 'digest'
require 'base64'

$max_filesize = 1048576 # 1 MB
$backup_url   = "http://localhost:4567/backup"


def usage 
  puts "bak <files>"
  sys.exit 1
end

def sanity_check_ok(file)
  error_message = ""
  if not File.exists? file 
    $stderr.puts "File #{file} does not exist" 
    return false 
  end 

  if !File.readable? file 
    $stderr.puts "File not readable, skipping #{file}"
    return false 
  end
 
  if File.size(file) > $max_filesize
    $stderr.puts "Filesize  exceeds  #{max_filesize} bytes, skipping #{file}"
    return false 
  end

  return true
end




def send_for_backup(file)
  # get Metadata

  path  = File.absolute_path (file)
  size  = File.size (path)
  file_content = File.read(path)
  file_lines = 0
  File.open(path).each.with_index do |line, index|
    file_content += line
    file_lines = index + 1
  end
  
  file_checksum = Digest::SHA256.hexdigest file_content

  #puts path
  #puts size
  #puts "Lines #{file_lines}"
  #puts file_checksum
#  puts Base64.encode64(file_content)
  #puts "-----------------------------------------------"
  
  RestClient.post$backup_url, :absolute_filename => path, :lines => file_lines, :size => size, :checksum => file_checksum, :encoded_content => Base64.encode64(file_content)



end




########### main
ARGV.each do |file_to_backup|

 send_for_backup(file_to_backup)  if  sanity_check_ok file_to_backup


end

