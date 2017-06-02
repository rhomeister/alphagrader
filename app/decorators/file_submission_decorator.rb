# frozen_string_literal: true
class FileSubmissionDecorator < SubmissionDecorator
  delegate_all

  def attributes
    [:status, :uploaded_by, :created_at, :team_members, :file_size,
     :download_url, :human_readable_language]
  end

  def human_readable_language
    LanguageSpecificRunfile::HUMAN_READABLE[language]
  end

  def file_size
    h.number_to_human_size(object.file_file_size)
  end

  def download_url
    h.link_to 'Download', file.expiring_url
  end
end
