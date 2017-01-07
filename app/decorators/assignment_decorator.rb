# frozen_string_literal: true
class AssignmentDecorator < Draper::Decorator
  delegate_all

  def due_date
    return nil if object.due_date.nil?
    I18n.l object.due_date, format: :long
  end

  def description
    h.raw(RDiscount.new(object.description).to_html)
  end
end
