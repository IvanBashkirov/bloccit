module PostsHelper
  def user_is_authorized_for_ce_post?(post)
     current_user && (current_user == post.user || current_user.admin? || current_user.moderator?)
  end

  def user_is_authorized_for_d_post?(post)
     current_user && (current_user == post.user || current_user.admin?)
  end


end
