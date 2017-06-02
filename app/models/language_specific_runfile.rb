# frozen_string_literal: true
class LanguageSpecificRunfile
  ROOT_SCRIPT_DIR = "#{Rails.root}/lib/run_scripts"
  FILES = {
    'c' => "#{ROOT_SCRIPT_DIR}/c",
    'cplus' => "#{ROOT_SCRIPT_DIR}/cplus",
    'java' => "#{ROOT_SCRIPT_DIR}/java",
    'javascript' => "#{ROOT_SCRIPT_DIR}/javascript",
    'python' => "#{ROOT_SCRIPT_DIR}/python",
    'ruby' => "#{ROOT_SCRIPT_DIR}/ruby"
  }.freeze

  HUMAN_READABLE = {
    'c' => 'C',
    'cplus' => 'C++',
    'java' => 'Java',
    'javascript' => 'Javascript',
    'python' => 'Python',
    'ruby' => 'Ruby'
  }.freeze

  def self.find(language)
    FILES[language]
  end

  def self.options_for_select
    HUMAN_READABLE.to_a.map(&:reverse)
  end
end
