module Display

  def welcome_message
    puts "\033[1;36m\nWelcome to the Task Master! "
  end

  def display_options
    puts <<-STRING
\033[1;31m
Here are the options\033[0;31m available to you:
\033[36m-----------------------------------------------
\033[33m'list'            -    list all of your tasks
'list with tags'  -    list all tasks along with their tags
'add'             -    add a new task to your list
'complete'        -    mark a task as completed
'delete'          -    delete a task from your list
'add tag'         -    create a new tag
'delete tag'      -    delete an existing tag
'assign tag'      -    assign a tag to an existing task
'view by tag'     -    view tasks by tag
'list tags'       -    list all existing tags
'help'            -    display this menu
'quit'            -    quit the program
\033[36m-----------------------------------------------\033[0m
STRING
  end

  def get_input
    self.input = gets.chomp.rstrip
  end

  def prompt_for_task
    print "\033[1;33mWhat would you like to add to your list?\033[0m"
  end

  def prompt_for_tag
    puts
    show_tags
    print "\033[1;33mPlease enter the id of the tag you would like to search for.\033[0m"
  end

  def prompt_for_tag_to_delete
    puts
    show_tags
    print "\033[1;33mPlease enter the id of the tag you would like to delete:\n\n\033[0m"
  end

  def show_list_with_tags
    puts
    puts "YOUR TO-DO LIST WITH TAGS:"
    puts
    puts Task.all_with_tags
  end

  def confirm_delete_task
    puts "You've got it!  Task #{input}: DELETED."
  end

  def show_list
    puts
    puts "YOUR TO-DO LIST:"
    puts
    puts Task.all
  end

  def show_tags
    puts Tag.all
  end

  def prompt_for_task_id_delete
    print "\033[1;33mPlease enter the id number of the task you would like to delete.\033[0m"
  end

  def confirm_assign_tag(task_id, tag_id)
    puts "You have assigned tag number #{tag_id} to task number #{task_id}."
  end

  def prompt_for_task_id_complete
    print "\033[1;33mPlease enter the id number of the task you would like to mark as complete. \033[0m"
  end

  def ask_for_command
    puts "\033[31mWhat would you like to do?\033[0m"
  end

  def escape_prompt
    puts " -  Enter \033[5m\033[33m'back' \033[0mto return to the main menu."
  end

  def invalid_command
    puts "\033[1;33mWhoops!  I didn't quite get that.\033[0m  Remember, you can say 'help' at any time to get a list of valid commands."
  end

  def task_to_assign
    puts "Which task would you like to assign a tag to?  Enter a task id."
  end

  def tag_to_assign
    puts "Which tag would you like to assign to that task?  Enter a tag id."
  end

end
