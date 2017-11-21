module UsersHelper
  def set_online(user)
    user.update_columns({online: true})
  end
  def set_offline(user)
    user.update_columns({online: false})
  end
end
