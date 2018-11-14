module ApplicationHelper
  def i(text, options={})
    I18n.t(text, options)
  end

  def get_class(path = nil)
    path && path == request.path ? 'list-group-item current-list' : 'list-group-item'
  end
end
