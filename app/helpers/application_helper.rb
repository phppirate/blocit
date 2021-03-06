module ApplicationHelper
  def control_group_tag(errors, &block)
    if errors.any?
      content_tag :div, capture(&block), class: 'control-group error'
    else
      content_tag :div, capture(&block), class: 'control-group'
    end
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render text).html_safe
  end

  def will_paginate(collection_or_options = nil, options = {})
    if collection_or_options.is_a? Hash
      options, collection_or_options = collection_or_options, nil
    end
    unless options[:renderer]
      options = options.merge :renderer => BootstrapLinkRenderer
    end
    super *[collection_or_options, options].compact
  end

  def comment_url_helper(comment)
    post = comment.post
    topic = post.topic
    [topic, post, comment]
  end
  def get_avtar(size = 'tiny')
    if current_user
      if size == 'tiny'
        demensions = '20px'
      elsif size == 'small'
        demensions = '30px'
      elsif size == 'profile'
        demensions = '45px'
      else
        demensions = '200px'
      end

      if current_user.avatar?

        if size = 'tiny'
          image_tag(current_user.avatar.tiny.url)
        elsif size = 'small'
          image_tag(current_user.avatar.small.url)
        elsif
          image_tag(current_user.avatar.profile.url)
        else
          image_tag(current_user.avatar.url)
        end

      else
        id = Digest::MD5::hexdigest(current_user.email.downcase)
        url = "https://secure.gravatar.com/avatar/#{id}.png"
        image_tag(url, width: "#{demensions}", height: "#{demensions}")
      end

    end
  end

end
