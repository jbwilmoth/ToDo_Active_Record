require 'active_record'

class Tag < ActiveRecord::Base
  has_many :task_tags
  has_many :tasks, through: :task_tags

  def self.add(input)
    Tag.create(tag_name: input)
  end

  def to_s
    "#{id.to_s.ljust(3)} | #{tag_name}"
  end
end
