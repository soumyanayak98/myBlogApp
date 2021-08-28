module ApplicationHelper
  # only available in views not in controllers 

  def gravatar_for (user , options = {size: 100})
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    image_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(image_url, alt: user.username, class: "rounded shadow mx-auto d-block")
  end

  # def curr_user
  #   @curr_user ||= User.find(session[:user_id]) if session[:user_id]
  # end

  # def logged_in?
  #   !!curr_user
  # end
end
