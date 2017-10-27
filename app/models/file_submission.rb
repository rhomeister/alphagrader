# frozen_string_literal: true
class FileSubmission < Submission
  validates :file, presence: true
  has_attached_file :file
  validates_attachment_content_type :file, content_type: 'application/zip'
  validates_attachment_file_name :file, matches: [/zip\z/]

  def download
    file.copy_to_local_file(:original, tempdir + '/zipfile.zip')
    Dir.chdir(tempdir) do
      raise 'Error while unzipping' unless system('unzip zipfile.zip')
    end
  end
end
