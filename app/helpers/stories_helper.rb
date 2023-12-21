module StoriesHelper
  def cover_image(story, size: { x: 250, y: 250 })
    image_tag story.cover_image.variant(resize_to_fill: [size[:x], size[:y]]), class:"cover-image" if story.cover_image.attached?
  end
end
