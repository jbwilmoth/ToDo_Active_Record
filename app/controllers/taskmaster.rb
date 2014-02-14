require_relative '../models/task'
require_relative '../../config/application'
require 'active_record'
# require '../../db'

module Display

  def welcome_message
  end

  def display_options
    puts "Here are the options available to you:"
    puts "-----------------------------------------------"
    puts "'list'       -    list all of your tasks"
    puts "'add'        -    add a new task to your list"
    puts "'complete'   -    mark a task as completed"
    puts "'delete'     -    delete a task from your list"
    puts "'help'       -    display this menu"
    puts "'quit'       -    quit the program"
    puts "-----------------------------------------------"
  end

  def get_input
    self.input = gets.chomp
  end

  def prompt_for_task
    puts "What would you like to add to your list?"
  end

  def prompt_for_task_id_delete
    puts "Please enter the id number of the task you would like to delete:"
  end

  def prompt_for_task_id_complete
    puts "Please enter the id number of the task you would like to mark as complete:"
  end

  def ask_for_command
    puts "whatcha wanna do?"
  end

  def escape_prompt
    puts "'skip' ---- to escape"
  end

end

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
    run_loop unless input == "quit"
  end

  def parse_input
    case input
    when "list"
      show_list
    when "add"
      create_task
    when "complete"
      complete_task
    when "delete"
      delete_task
    when "help"
      display_options
    end
  end


  def show_list
    puts Task.all
  end

  def create_task
    escape_prompt
    prompt_for_task
    get_input
    Task.add(input) unless input == "skip"
  end

  def delete_task
    escape_prompt
    prompt_for_task_id_delete
    get_input
    Task.delete(input)  unless input == "skip"
  end

  def complete_task
    escape_prompt
    prompt_for_task_id_complete
    input = get_input
    Task.complete(input)  unless input == "skip"
  end
end

task_master =TaskMaster.new

