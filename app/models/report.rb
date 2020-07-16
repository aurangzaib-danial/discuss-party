class Report < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  enum report_type: {rude: 0, harassment: 1, spam: 2, copyright: 3}

  def self.report_types
    defined_enums["report_type"].keys
  end
end
