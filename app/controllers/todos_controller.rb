class TodosController < ApplicationController
  def index
  	 @todo_items=Todo.all
  	 @new_todo= Todo.new
  end

 def add
 	todo = Todo.create(:todo_item => params[:todo][:todo_item],:deadLine =>Time.now)
 	todo.save
 	if !todo.valid?
 		flash[:error] = todo.errors.full_messages.join("<br>").html_safe
 	else
 		flash[:success]= "La tarea fue creada exitosamente"
 	end	
 	redirect_to index_path
 end

   def complete
   	if params[:commit] == "Complete Todos"
		params[:todos_checkbox].each do |check|
			todo_id = check
			t = Todo.find_by_id(todo_id)
		    t.update_attribute(:completed, true)
		    t.update_attribute(:deadLine, nil)
		end
	elsif params[:commit] == "Delete"
	  if params[:todos_checkbox] != nil 
	  	  ids = params[:todos_checkbox].collect {|id| id.to_i} 
		  ids.each do |id|
			Todo.where(:id =>id).destroy_all
		  end
	   end
		
		  flash[:success]= "Las tareas se eliminaron exitosamente"

	end
	
     
    redirect_to :action => 'index'

 	end  

end
