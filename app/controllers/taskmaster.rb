require_relative '../models/task'
require_relative '../../config/application'
require_relative 'display'
require 'active_record'

class TaskMaster
  include Display
  attr_accessor :input

  def initialize
    run!
    @input = nil
  end

  def run!
    welcome_message
    display_options
    run_loop
  end

  def run_loop
    ask_for_command
    get_input
    parse_input
    run_loop unless input == "quit" or input == "exit"
  end

  def parse_input
    case input.downcase
    when "list"
      show_list
    when "add"
      create_task
    when "complete"
      complete_task
    when "delete"
      delete_task
    when "add tag"
      add_tag
    when "view by tag"
      view_by_tag
    when "list tags"
      show_tags
    when "assign tag"
      assign_tag
    when "list with tags"
      show_list_with_tags
    when "help"
      display_options
    when "quit", "exit"
    else
      invalid_command
    end
  end

  def assign_tag
    task_to_assign
    task_id = get_input
    tag_to_assign
    tag_id = get_input
    TaskTag.create(task_id: task_id, tag_id: tag_id)
  end

  def add_tag
    Tag.add(get_input)
  end

  def view_by_tag
    prompt_for_tag
    escape_prompt
    get_input
    puts Tag.where("tag_name = ?", input).first.tasks unless input == "back" || input == "^[[A"
  end

  def show_list
    puts Task.all
  end

  def show_list_with_tags
    puts Task.all_with_tags
  end

  def show_tags
    puts Tag.all
  end

  def create_task
    prompt_for_task
    escape_prompt
    get_input
    Task.add(input) unless input == "back" || input == "^[[A"
  end

  def delete_task
    prompt_for_task_id_delete
    escape_prompt
    get_input
    Task.delete(input) unless input == "back"
  end

  def complete_task
    prompt_for_task_id_complete
    escape_prompt
    input = get_input
    Task.complete(input) unless input == "back"
  end
end

task_master =TaskMaster.new



