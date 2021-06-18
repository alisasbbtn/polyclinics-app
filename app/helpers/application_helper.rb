module ApplicationHelper
  def active_class_if_path(path)
    return 'active' if request.path == path

    ''
  end

  def photo_or_placeholder(resource, width, height, class_name = nil)
    if resource.photo.attached?
      cl_image_tag(resource.photo.key, width: width, height: height, gravity: 'faces', crop: 'fill', class: class_name)
    else
      image_tag('placeholder.jpg', width: width, height: height, class: class_name)
    end
  end
end
