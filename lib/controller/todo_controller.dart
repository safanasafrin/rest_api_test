import 'package:rest_api_test/models/todo.dart';
import 'package:rest_api_test/repository/repository.dart';

class TodoController{
  final Repository _repository;

  TodoController(this._repository);

  Future<List<Todo>>fetchTodoList() async{
    return _repository.getTodoList();
  }
  Future<String>updatePutCompleted(Todo todo)async{
    return _repository.putCompleted(todo);
  }
  Future<String>updatePatchCompleted(Todo todo)async{
    return _repository.patchCompleted(todo);
  }
  Future<String>deleteTodo(Todo todo)async{
    return _repository.deleteTodo(todo);
  }
  Future<String>postTodo(Todo todo)async{
    return _repository.postTodo(todo);
  }
}