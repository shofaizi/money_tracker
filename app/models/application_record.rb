class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def error_desciption
    errors.full_messages.join(", ") 
  end
end
