class Newsletter < ActionMailer::Base
  default from: "from@example.com"

  def mailout 
  	members = User.confirmed.all.map { |u| u.email } 
  	mail :to => [], :bcc => members, :subject => "My amazing subject"

  end 
end
