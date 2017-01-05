# frozen_string_literal: true
class TestDecorator < Draper::Decorator
  delegate_all

  def description
    RDiscount.new(object.description).to_html.html_safe
  end

  def type_name
    h.content_tag :span, type.camelcase, class: 'label label-info'
  end

  def private_indicator
    return if public
    h.icon 'eye-slash', library: :font_awesome, title: 'Private test: invisible to students'
  end

  def panel_edit_link
    return unless h.can?(:edit, object)
    h.content_tag(:div, class: 'pull-right') do
      h.link_to 'Edit', h.edit_assignment_test_path(assignment, object)
    end
  end
end
