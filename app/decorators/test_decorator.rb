# frozen_string_literal: true
class TestDecorator < Draper::Decorator
  delegate_all

  def description
    h.raw(RDiscount.new(object.description).to_html)
  end

  def type_name
    h.content_tag :span, object.class.model_name.human, class: 'label label-info'
  end

  def private_indicator
    return if public
    h.icon 'eye-slash', library: :font_awesome, title: 'Private test: invisible to students'
  end

  def panel_manage_links
    h.content_tag(:div, class: 'pull-right') do
      links = []
      if h.can?(:edit, object)
        links << h.link_to('Edit',
                           h.edit_assignment_test_path(assignment, object),
                           id: "edit_test_#{id}")
      end

      if h.can?(:destroy, object)
        links << h.link_to(h.icon(:trash, library: :font_awesome),
                           h.assignment_test_path(assignment, object),
                           data: { confirm: 'Are you sure?' }, method: :delete,
                           class: :danger, id: "delete_test_#{id}")
      end

      h.safe_join(links, ' | ')
    end
  end
end
