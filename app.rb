Bundler.require
require 'active_support/core_ext'
require File.expand_path('../chatwork.rb', __FILE__)
config = YAML.load_file(File.expand_path('../config.yml', __FILE__))

AWS.config(config["aws"])
cw = AWS::CloudWatch.new
message = "今月のこれまでに使ったAWSの費用はこれくらいになったぞ\n-------------------\n"
message += cw.metrics.filter("namespace","AWS/Billing").map do |m|
  st = m.statistics(start_time: Time.now-24.hours, end_time: Time.now, statistics: ["Average"], period: 60*60*24)
  service_name = m.dimensions.detect{|d| d[:name]=="ServiceName"}.try{|d| d[:value]} || "Total"
  {name: service_name, currency: (st.datapoints.first.try{|d| d[:average]}||0.0)}
end.sort{|a,b| b[:currency]<=>a[:currency]}.map do |h|
  "#{h[:name]}: $#{h[:currency].round(2)}"
end.join("\n")

Chatwork.new(config["chatwork"]).message(message)
