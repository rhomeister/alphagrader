# frozen_string_literal: true

class FileSubmission < Submission
  validates :file, presence: true
  has_attached_file :file
  validates_attachment_content_type :file, content_type: 'application/zip'
  validates_attachment_file_name :file, matches: [/zip\z/]

  # A file submission does not have automatically detectable contributors
  def detectable_contributors?
    false
  end

  def file_url(filename)
    # todo
  end

  def download
    file.copy_to_local_file(:original, tempdir + '/zipfile.zip')
    `unzip #{tempdir}/zipfile.zip -d #{tempdir}`
  end
end
