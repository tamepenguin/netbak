#!/usr/bin/env ruby
require 'sinatra'
require 'json'

get '/' do
  'Hello World'
end

post '/data' do 
  $stderr.puts params  if params
  "Danke"
end

  
