class ApplicationRecord < ActiveRecord::Base
  include Paperclip::Glue
  self.abstract_class = true
end
