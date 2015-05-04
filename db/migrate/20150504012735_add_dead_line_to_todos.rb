class AddDeadLineToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :deadLine, :date
  end
end
