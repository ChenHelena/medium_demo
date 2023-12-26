module UsersHelper
  def avatar(user, size: { x: 250, y: 250 })
    image_tag user.avatar.variant(resize_to_fill: [size[:x], size[:y]]), class: "user-avatar" if user && user.avatar.attached?
  end
end