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
  var category;
  List<Category> _categoryList=List<Category>();
  @override
  void initState(){
    super.initState();
    getAllCategories();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey<ScaffoldState>();

  getAllCategories() async{
    _categoryList=List<Category>();
    var categories=await _categoryService.getCategories();
    categories.forEach((category){
      setState(() {
        var model=Category();
        model.name=category['name'];
        model.id=category['id'];
        model.description=category['description'];
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
                  getAllCategories();
                  Navigator.pop(context);
                  _showSnackBar(Text('Added Successfully',style: TextStyle(
                    color: Colors.green
                  ),
                  ));
                  _categoryDescription.text='';
                  _categoryName.text='';
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
                  _category.id=category[0]['id'];
                  _category.name=_editcategoryName.text;
                  _category.description=_editcategoryDescription.text;
                  var result=await _categoryService.updateCategory(_category);
                  if (result>0){
                    Navigator.pop(context);
                    getAllCategories();
                    _showSnackBar(Text('Success'));
                  }
                  print(result);
              } ,
              child: Text('Update'),
            )
          ]
          ,title: Text('Category Edit Form'),
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
_deleteCategoryDialog(BuildContext context,categoryId){
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
              child: Text('Cancel',
                style: TextStyle(
                  color: Colors.green
              ),),
            ),
            FlatButton(
              onPressed:()async{ 
                _categoryService.deleteCategory(categoryId);
                Navigator.pop(context);
                getAllCategories();
                _showSnackBar(Text('Successfully deleted'));
              } ,
              child: 
              Text('Confirm',
                style: TextStyle(
                  color: Colors.red
              ),
              ),
            )
          ]
          ,title: Text('Are you sure you want to delete ?'),
        );
      }
    );
  }

  _editCategory(BuildContext context,categoryId) async{
    category=await _categoryService.getCategoryById(categoryId);
    setState(() {
      _editcategoryName.text=category[0]['name'] ?? 'No name';
      _editcategoryDescription.text=category[0]['description'] ?? 'No description';
    });
  _editCategoryDialog(context);
  }

  _showSnackBar(message){
    var _snackBar=SnackBar(
      content: message,
    );
    _scaffoldKey.currentState.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                      onPressed: (){
                        _editCategory(context,_categoryList[index].id);
                      },
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_categoryList[index].name),
                        IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: (){
                          _deleteCategoryDialog(context,_categoryList[index].id);
                        },
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