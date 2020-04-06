import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toogleFavorite;
  final Function isFavorite;

  MealDetailScreen(this.toogleFavorite,this.isFavorite);


  Widget buildSectionTitle(BuildContext context, String title){
      return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              title,
              style: Theme.of(context).textTheme.title,
            ),
          );
    }

  Widget buildContainer(Widget child){
    return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            height: 150,
            width: 300,
            child: child,
    );
  }


  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;

    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

  

    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
          child: Column(
          children: <Widget>[
            Container(
              height: 150,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context,'Ingredients'),
            buildContainer(ListView.builder(itemBuilder: (ctx, index) => Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(selectedMeal.ingredients[index],),
                ),
                color:  Theme.of(context).accentColor,
              ),
              itemCount: selectedMeal.ingredients.length,),
            ),
            buildSectionTitle(context,'Steps'),
            buildContainer(ListView.builder(
              itemCount: selectedMeal.steps.length,
              itemBuilder: (ctx, index) => Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('${(index +1)}'),
                    ),
                    title: Text(selectedMeal.steps[index],),
                  ),
                  Divider(),
                ],
              ),

            ),),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavorite(mealId) ? Icons.star : Icons.star_border,
          ),
        onPressed: () => toogleFavorite(mealId),
        ),
    );
  }
}