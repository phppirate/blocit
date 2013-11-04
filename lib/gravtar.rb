module Gravtar

  def get_avtar
    if current_user
      if current_user.avatar?
        image_tag(current_user.avatar.tiny.url)
      else
        id = Digest::MD5::hexdigest(current_user.email.downcase)
        url = "https://secure.gravatar.com/avatar/#{id}.png"
        image_tag(url, width: "20px", height: "20px")
      end
    end
  end



end