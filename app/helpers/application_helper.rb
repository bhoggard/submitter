module ApplicationHelper
  def flash_class(level)
    case level
    when :notice then 'info'
    when :error then 'error'
    when :alert then 'warning'
    end
  end

  def body_class
    "#{controller.controller_name} #{controller.controller_name}_#{controller.action_name}"
  end

  def artist_name(work)
    "#{work.first_name} #{work.last_name}"
  end

  def work_dimensions(work)
    s = "#{work.height} x #{work.width}"
    s += " x #{work.length}" if work.length.present?
    "#{s} inches"
  end

  def courtesy_line(work)
    work.courtesy.present? ? work.courtesy : 'the artist'
  end
  
end
