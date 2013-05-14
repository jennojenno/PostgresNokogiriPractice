require 'rubygems'
require 'nokogiri'
require 'logger'
require_relative 'wiki_import'
require 'pry'

logger = Logger.new(STDOUT)
logger.level = Logger::DEBUG

document = WikiImport.new(logger) #where our callbacks live
parser = Nokogiri::XML::SAX::Parser.new(document)
begin
  parser.parse(File.open(ARGV[0]))
rescue
	logger.error "Problem saving file"
	document.close_file
end

puts "Found #{document.page_count} pages"
