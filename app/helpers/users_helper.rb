module UsersHelper
  
  def twitter_profile(user)
    "<strong>Twitter:</strong> #{link_to "twitter.com/#{h user.twitter_username}", "http://twitter.com/#{h user.twitter_username}"}" if !user.twitter_username.blank?
  end
  
	def delicious_profile(user)
	  "<strong>Delicious:</strong> #{link_to "del.icio.us/#{h user.delicious_username}", "http://del.icio.us/#{h user.delicious_username}"}" if !user.delicious_username.blank?
  end
  
	def personal_url(user)
	  url = user.personal_url
	  url = "http://" + url unless url.starts_with?("http://")
	  "<strong>Personal URL:</strong> #{link_to h(user.personal_url), url}" if !user.personal_url.blank?
  end
  
	def company(user)
	  "<strong>Company:</strong> #{h user.company}" if !user.company.blank?
  end
  
	def bio(user)
	  "<strong>Bio:</strong> #{h user.bio}" if !user.bio.blank?
  end
  
end
