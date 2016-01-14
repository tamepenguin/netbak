#!/usr/bin/env ruby
require 'sinatra'
require 'json'

get '/' do
  'Hello World'
end

post '/backup' do 

  puts request.ip
  puts request.host
  puts params[:absolute_filename]
  
  "Done"
end


