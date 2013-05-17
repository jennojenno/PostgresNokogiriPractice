require "spec_helper"

describe Newsletter do
  describe "An exciting newsletter mailout" do 
  	before do 
  		@email = Newsletter.mailout.deliver 
  		# devise will require confirmation so to skip this... 
  		3.times { 
  			user = User.make! 
  			user.skip_confirmation!
  			user.save!
  			user }
  			@members = User.all.map {|u| u.email }

  			#unregistered user 
  			User.make! 
  	end 

  	it "should send to SMTP server" do 
  		ActionMailer::Base.deliveries.length.should > 0 
  	end 

  	it "should have a subject" do 
  		@email.subject.should eq("My amazing subject")
  	end 

  	it "should be sent to all our users" do 
  		#can test the recipients
  		@email.bcc.should eq(@members)

  	end 

  	it "should not put anyone in the to address" do 
  		@email.to.should be_empty 
  	end 

  	it "should greet the member" do 
  		@email.encoded.should match /Hello dear/ 
  	end 
  end 
end
