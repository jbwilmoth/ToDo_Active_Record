require 'active_record'

class TaskTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :task

end
