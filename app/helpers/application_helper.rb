# frozen_string_literal: true
module ApplicationHelper
  # Bootstrap 3 alert classes for flash hash in application layout.
  def flash_class(level)
    case level.to_s
    when 'notice' then
      'alert alert-info'
    when 'success' then
      'alert alert-success'
    when 'error' then
      'alert alert-danger'
    when 'alert' then
      'alert alert-warning'
    end
  end

  def no_results_found_row(colspan)
    "<tr><td class=\"none\" colspan=\"#{colspan}\">#{I18n.t(:no_results_found)}</td></tr>".html_safe
  end
end
