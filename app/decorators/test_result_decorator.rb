# frozen_string_literal: true
class TestResultDecorator < Draper::Decorator
  delegate_all

  def created_at
    return nil if object.created_at.nil?
    I18n.l object.created_at, format: :long
  end

  def title
    h.safe_join([result_icon, title_text], ' ')
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

  def result_icon
    return h.icon :check, library: :font_awesome if success?
    return h.icon :times, library: :font_awesome if failure? || error?
  end
end
