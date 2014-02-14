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
    when "list", "list all", "show all", "list tasks", "view all", "view tasks"
      show_list
    when "add", "add task"
      create_task
    when "complete", "complete task"
      complete_task
    when "delete", "delete task"
      delete_task
    when "add tag"
      add_tag
    when "view by tag"
      view_by_tag
    when "list tags", "view tags"
      show_tags
    when "delete tag"
      delete_tag
    when "assign tag"
      assign_tag
    when "list with tags", "list all with tags", "show with tags", "view with tags", "view all with tags"
      show_list_with_tags
    when "help", "menu"
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
    confirm_assign_tag(task_id, tag_id)
  end

  def add_tag
    Tag.add(get_input)
  end

  def view_by_tag
    prompt_for_tag
    escape_prompt
    get_input
    puts find_tasks_by_tag
  end

  def find_tasks_by_tag
    Tag.where("id = ?", input).first.tasks unless input == "back" || input == "^[[A"
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
    confirm_delete_task
    Task.delete(input) unless input == "back"
  end

  def delete_tag
    prompt_for_tag_to_delete
    get_input
    Tag.delete(input) unless input == "back"
  end

  def complete_task
    prompt_for_task_id_complete
    escape_prompt
    input = get_input
    Task.complete(input) unless input == "back"
  end
end

task_master =TaskMaster.new



