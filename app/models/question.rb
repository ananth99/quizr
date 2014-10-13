class Question < ActiveRecord::Base
  has_many :options

  self.per_page = 1
end
