import 'package:todo_flutter/models/category.dart';
import 'package:todo_flutter/repositories/repository.dart';
class CategoryServices{

  Repository _repository;

  CategoryServices(){
    _repository=Repository();
  }

  saveCategory(Category category)async{
   return await _repository.save('categories',category.categoryMap());
  }

  getCategories() async{
   return await _repository.getAll('categories');
  }

  getCategoryById(categoryId) async{
    return await _repository.getById('categories',categoryId);
  }

  updateCategory(Category category) async{
   return await _repository.update('categories',category.categoryMap());
  }
  deleteCategory(categoryId)async{
    return await _repository.delete('categories',categoryId);
  }
}