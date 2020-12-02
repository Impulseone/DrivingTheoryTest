import 'package:dirving_theory_test/extension/categories_provider.dart';
import 'package:rxdart/rxdart.dart';

class CategoriesBloc {
  final BehaviorSubject<List<Category>> _categoriesController =
  BehaviorSubject<List<Category>>();

  Stream<List<Category>> get categories => _categoriesController.stream;

  Future<List<Category>> generateCategories() async {
    List<Category> categories = List();
    categories = await CategoriesProvider().generateCategoriesInfo();
    _categoriesController.sink.add(categories);
    return categories;
  }

  void dispose() {
    _categoriesController.close();
  }
}
