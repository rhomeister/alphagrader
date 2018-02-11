# frozen_string_literal: true

class TestResultDecorator < Draper::Decorator
  delegate_all

  def created_at
    return nil if object.created_at.nil?
    I18n.l object.created_at, format: :long
  end

  def title
    h.safe_join([result_icon, type_name, title_text, execution_time], ' ')
  end

  def help_page_url
    test_type.new.decorate.help_page_url
  end

  def type_name
    test_type.new.decorate.type_name
  end

  def title_text
    name
  end

  def panel_context
    return 'success' if success?
    return 'danger' if failure?
    return 'danger' if error?
  end

  private

  def execution_time
    return nil if object.execution_time.nil?
    content = "Execution Time: #{h.number_with_precision object.execution_time, precision: 2}s"
    h.content_tag :span, content, class: 'label label-info pull-right'
  end

  def result_icon
    return h.icon :check, library: :font_awesome if success?
    return h.icon :times, library: :font_awesome if failure? || error?
  end
end
