class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  extend Slugify
end
