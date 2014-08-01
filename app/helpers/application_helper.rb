module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def reload_flash
    page.replace "flash_messages", partial: 'layouts/flash'
  end
end
