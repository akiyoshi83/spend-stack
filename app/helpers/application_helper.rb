module ApplicationHelper
  def twitter_login
    if Rails.env == 'development'
      '/auth/twitter?account=dummy'
    else
      '/auth/twitter'
    end
  end
end
