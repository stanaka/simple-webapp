require 'rubygems'
require 'sinatra/base'

class App < Sinatra::Base
    get '/' do
        "Hello, World!!"
    end

    get '/id' do
        file = File.new("/var/lib/mackerel-agent/id", "r")
        file.gets
    end
end
