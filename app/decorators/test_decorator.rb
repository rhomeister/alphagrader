# frozen_string_literal: true
class TestDecorator < Draper::Decorator
  delegate_all

  def description
    h.raw(RDiscount.new(object.description).to_html)
  end

  def type_name
    if help_page_url
      h.link_to help_page_url, help_page_url, target: :blank do
        type_name_text
      end
    else
      type_name_text
    end
  end

  def type_name_text
    h.content_tag :abbr, class: 'label label-info',
      data: {trigger: 'hover', html: true, toggle: 'popover', content: popover_content},
      title: object.class.model_name.human do
        h.safe_join([object.class.model_name.human,
                    h.icon('info-circle', library: :font_awesome)], ' ')
    end
  end

  def popover_content
    object.class.detailed_description
  end

  def help_page_url
    object.class.help_page_url
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
