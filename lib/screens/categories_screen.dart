import 'package:flutter/material.dart';
import 'package:todo_flutter/models/category.dart';
import 'package:todo_flutter/services/category_service.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  var _categoryName=TextEditingController();
  var _categoryDescription=TextEditingController();
  var _category=Category();
  var _categoryService=CategoryServices();

  _showFormInDialog(BuildContext context){
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (param){
        return AlertDialog(
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.pop(context);
              } ,
              child: Text('Cancel'),
            ),
            FlatButton(
              onPressed:(){
                  _category.name=_categoryName.text;
                  _category.description=_categoryDescription.text;
                  _categoryService.saveCategory(_category);
              } ,
              child: Text('Save'),
            )
          ]
          ,title: Text('Category Form'),
        content:SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _categoryName,
                decoration: InputDecoration(
                  labelText: 'Category name',
                  hintText: 'Write category name'
                ),
              ),
              TextField(
                controller: _categoryDescription,
                decoration: InputDecoration(
                  labelText: 'Category description',
                  hintText: 'Write category description '
                ),
              ),
            ],
          ),
        ) ,
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: RaisedButton(
          elevation: 0.0,
          color: Colors.red,
          child: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text('TODO'),
      ),
      body:
      Center(
        child:Text('Welcome to category screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showFormInDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}