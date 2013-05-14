require 'spec_helper'
require 'wiki_import'

describe 'The article parser' do 
	before do 
		@article = Article.make
		dummy_text = "<page><title>Hello world</title><text>It's a wonderful day!</text></title></page>"

		@document = WikiImport.new(Rails.logger) #where our callbacks live

		# @document.should_receive(:start_document).once 
		# @document.should_receive(:start_element_namespace) 
		# @document.should_receive(:end_document).once 

		@parser = Nokogiri::XML::SAX::Parser.new(@document)
		@parser.parse(dummy_text)

	end 

	it "creates an article in the database" do 
		Article.count.should eq(1)
		Article.title.should eq("Hello world")
		Article.body.should eq("It's a wonderful day!")
		# @actual = Article.first 
		# @actual.title.should = @article.title 

	end 


end 





# describe Article do 
# 	before do 
# 		3.times { |i| Article.create(:title => title) }
# 	end 

# 	it { should make the article count at 3 } do
# 		#Article.length == 3 
# 		expects(assigns(:articles)).length.to eq(3)
# 	end 

# end 
