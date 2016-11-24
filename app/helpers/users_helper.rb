module UsersHelper
  def fullusername(user)
    "#{user.first_name} #{user.last_name}"
  end
end
