class FavoriteMailer < ActionMailer::Base
  default from: "blocit.herokuapp.com"

  def new_comment(user, post, comment)
    @user = user
    @post = post
    @comment = comment

    # New Headers
    headers["Message-ID"] = "<comments/#{@comment.id}@blocit.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{@post.id}@blocit.herokuapp.com>"
    headers["References"] = "<post/#{@post.id}@blocit.herokuapp.com>"

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end