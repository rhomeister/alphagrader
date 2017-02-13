# frozen_string_literal: true
Paperclip::Attachment.default_options[:storage] = :s3
Paperclip::Attachment.default_options[:s3_credentials] =
  "#{Rails.root}/config/amazon_s3.yml"

Paperclip::Attachment.default_options[:s3_headers] =
  { 'Expires' => 10.years.from_now.httpdate,
    'Cache-Control' => 'max-age=315576000' }

Paperclip::Attachment.default_options[:s3_host_name] = ENV.fetch('S3_HOST_NAME')

Paperclip::Attachment.default_options[:url] = ':s3_alias_url'

Paperclip::Attachment.default_options[:s3_host_alias] = ENV.fetch('ASSET_HOST')

Paperclip::Attachment.default_options[:s3_region] = ENV.fetch('S3_REGION')
Paperclip::Attachment.default_options[:s3_permissions] = :private

# always enforce SSL on paperclip assets
Paperclip::Attachment.default_options[:s3_protocol] = 'https'

Paperclip::Attachment.default_options[:path] =
  "#{Rails.env}/:class/:id_partition/:attachment/:style-:fingerprint.:extension"

if Rails.env.test?
  # for testing, use the local file system
  Paperclip::Attachment.default_options[:storage] = :filesystem
  Paperclip::Attachment.default_options[:path] =
    '/tmp/alphagrader-test/attachments/:class/:id/:style/:basename.:extension'
end

Paperclip::Attachment.default_options[:default_url] =
  'images/missing/:class/:attachment/:style/missing.png'

require 'paperclip/media_type_spoof_detector'
module Paperclip
  # fix for https://github.com/thoughtbot/paperclip/issues/1470
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end
