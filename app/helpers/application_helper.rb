module ApplicationHelper
  def active_class_if_path(path)
    return 'active' if request.path == path

    ''
  end
end
