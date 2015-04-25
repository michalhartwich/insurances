module ItemsHelper
  def show_active_when(action)
    ((action_name===action) ? ' active' : '')
  end
end
