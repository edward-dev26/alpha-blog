module ApplicationHelper
  def avatar_for(user, options = { size: 200 })
    image_tag("https://i.pravatar.cc/#{options[:size]}?u=#{user.email}", alt: user.username, class: "rounded shadow")
  end
end
