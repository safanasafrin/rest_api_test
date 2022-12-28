import 'package:flutter/material.dart';
import 'package:rest_api_test/controller/todo_controller.dart';
import 'package:rest_api_test/models/todo.dart';
import '../repository/todo_repository.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var todoController = TodoController(TodoRepository());
    todoController.fetchTodoList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('HomeScreen'),
      ),
      body: FutureBuilder<List<Todo>>(
        future: todoController.fetchTodoList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('error'),
            );
          }
          return buildBodyContent(snapshot, todoController);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Todo todo=Todo(userId: 3,title: 'sample',completed: false);
          todoController.postTodo(todo);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  SafeArea buildBodyContent(
      AsyncSnapshot<List<Todo>> snapshot, TodoController todoController) {
    return SafeArea(
        child: ListView.separated(
            itemBuilder: (context, index) {
              var todo = snapshot.data?[index];
              return Container(
                height: 100.0,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(flex: 1, child: Text('${todo?.id}')),
                    Expanded(flex: 2, child: Text('${todo?.title}')),
                    Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                todoController
                                    .updatePatchCompleted(todo!)
                                    .then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          duration:
                                          const Duration(milliseconds: 500),
                                          content: Text('$value')));
                                });
                              },
                              child: buildCallContainer(
                                  'patch', Color(0xFFFFE0B2)),
                            ),
                            InkWell(
                              onTap: () {
                                todoController.updatePutCompleted(todo!);
                              },
                              child:
                              buildCallContainer('put', Color(0xFFE1BEE7)),
                            ),
                            InkWell(
                              onTap: () {
                                todoController.deleteTodo(todo!).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          duration:
                                          const Duration(milliseconds: 500),
                                          content: Text('$value')));
                                });
                              },
                              child: buildCallContainer(
                                  'delete', Color(0xFFFFCDD2)),
                            )
                          ],
                        )),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 0.5,
                height: 0.5,
              );
            },
            itemCount: snapshot.data?.length ?? 0));
  }

  Container buildCallContainer(String title, Color color) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(child: Text('$title')),
    );
  }
}
