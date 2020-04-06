import 'package:flutter/material.dart';


import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryRecipes extends StatefulWidget {
  static const routeName = '/category-recipes';

  final List<Meal> availableMeals;

  CategoryRecipes(this.availableMeals);

  @override
  _CategoryRecipesState createState() => _CategoryRecipesState();
}

class _CategoryRecipesState extends State<CategoryRecipes> {
  String categoryTitle;
  List<Meal> displayedMeals;
  bool _loadedInitData = false;


  @override
  void didChangeDependencies() {
    if(!_loadedInitData){
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
     categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    displayedMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void removeMeal(String mealId){
    setState(() {
      displayedMeals.removeWhere((meal) => mealId == meal.id);
    });
  }


  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
              id: displayedMeals[index].id,
              title: displayedMeals[index].title,
              imageUrl: displayedMeals[index].imageUrl,
              duration: displayedMeals[index].duration,
              complexity: displayedMeals[index].complexity,
              affordability: displayedMeals[index].affordability,
              );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
