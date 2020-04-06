import 'package:flutter/material.dart';
import 'package:food_recipe_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = './filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
   bool isGlutenFree = false;
   bool isLactoseFree = false;
   bool isVegan = false;
   bool isVegetarian = false;

  @override
  initState(){
    isGlutenFree = widget.currentFilters['gluten'];
    isLactoseFree = widget.currentFilters['lactose'];
    isVegan = widget.currentFilters['vegan'];
    isVegetarian = widget.currentFilters['vegetarian'];

    super.initState();
  }

  Widget buildSwitchListTile(String title, String subTitle,bool currentValue, Function updateValue){
    return SwitchListTile(
            title: Text(title),
            value: currentValue, 
            subtitle: Text(subTitle),
            onChanged: updateValue
            );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed:
          () {
            final selectedFilters = {
              'gluten' : isGlutenFree,
              'lactose' : isLactoseFree,
              'vegetarian' : isVegetarian,
              'vegan' : isVegan,
            };
            widget.saveFilters(selectedFilters);
          },
           ),
        ],
        ),
      drawer: MainDrawer(),  
      body: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          child: Text('Adjust your meal selection',
          style: Theme.of(context).textTheme.title,
          ),
        ),
        Expanded(child: ListView(children: <Widget>[
          buildSwitchListTile('Gluteen-Free', 'Only include gluteen free meals', isGlutenFree, 
          (newValue){
            setState(() {
              isGlutenFree = newValue;
            });
          }
          ),
          buildSwitchListTile('Lactose-Free', 'Only include lactose free meals', isLactoseFree, 
          (newValue){
            setState(() {
              isLactoseFree = newValue;
            });
          }
          ),
          buildSwitchListTile('Vegetarian', 'Only include vegetarian free meals', isVegetarian, 
          (newValue){
            setState(() {
              isVegetarian = newValue;
            });
          }
          ),
          buildSwitchListTile('Vegan', 'Only include vegan free meals', isVegan, 
          (newValue){
            setState(() {
              isVegan = newValue;
            });
          }
          ),
        ],))
      ],),
    );
  }
}