module ApplicationHelper
  def i(text, options={})
    I18n.t(text, options)
  end

  def get_class(path = nil)
    path && path == request.path ? 'list-group-item current-list' : 'list-group-item'
  end

  def get_selected_val(group)
    return %w[Active true]    if group.active?
    return %w[Inactive false] if !group.active?
  end

  def status_list
    [%w[Active true], %w[Inactive false]]
  end
end
