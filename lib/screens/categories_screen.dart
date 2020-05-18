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
  var _editcategoryName=TextEditingController();
  var _editcategoryDescription=TextEditingController();
  var _category=Category();
  var _categoryService=CategoryServices();

  List<Category> _categoryList=List<Category>();
  @override
  void initState(){
    super.initState();
    getAllCategories();
  }

  getAllCategories() async{
    var categories=await _categoryService.getCategories();
    categories.forEach((category){
      setState(() {
        var model=Category();
        model.name=category['name'];
        _categoryList.add(model);
        });
      });
  }

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
              onPressed:()async{
                  _category.name=_categoryName.text;
                  _category.description=_categoryDescription.text;
                  var result=await _categoryService.saveCategory(_category);
                  print(result);
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
    _editCategoryDialog(BuildContext context){
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
              onPressed:()async{
                  _category.name=_categoryName.text;
                  _category.description=_categoryDescription.text;
                  var result=await _categoryService.saveCategory(_category);
                  print(result);
              } ,
              child: Text('Save'),
            )
          ]
          ,title: Text('Category Form'),
        content:SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _editcategoryName,
                decoration: InputDecoration(
                  labelText: 'Category name',
                  hintText: 'Write category name'
                ),
              ),
              TextField(
                controller: _editcategoryDescription,
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

  _editCategory(BuildContext context,categortId) async{
    var category=await _categoryService.getCategoryById(categortId);
    setState(() {
      _editcategoryName.text=category[0]['name'];
      _editcategoryDescription.text=category[0]['description'];
    });
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
      ListView.builder(itemCount: _categoryList.length,itemBuilder: (context,index){
        return Card(
                      child: ListTile(
                      leading: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: (){},
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_categoryList[index].name),
                        IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: (){},
                      )
                    ],
                  ),
                ),
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showFormInDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}