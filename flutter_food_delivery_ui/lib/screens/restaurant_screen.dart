import 'package:app/models/food.dart';
import 'package:app/models/restaurant.dart';
import 'package:app/widgets/rating_stars.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatefulWidget {
  final Restaurant restaurant;

  RestaurantScreen({required this.restaurant});


  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {

  _buildMenuItem(Food menuItem){
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 175.0,
            width: 175.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(menuItem.imageUrl),
                fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.circular(15.0)
            ),
          ),
          Container(
            height: 175.0,
            width: 175.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              gradient: LinearGradient(
                begin: Alignment.topRight, end: Alignment.bottomLeft,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black87.withOpacity(0.3),
                  Colors.black54.withOpacity(0.3),
                  Colors.black38.withOpacity(0.3),
                ],
                stops: [0.1,0.4,0.6,0.9],
              )
            ),
          ),
          Positioned(
            bottom: 65.0,
            child: Column(
              children: [
                Text(
                  menuItem.name,
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                Text('\$${menuItem.price}',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),),
              ],
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: Container(
              width: 48.0,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {  },
                iconSize: 30.0,
                color: Colors.white,
                ),
            )
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: widget.restaurant.imageUrl,
                child: Image(
                  image: AssetImage(widget.restaurant.imageUrl),
                  height: 220.0,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      iconSize: 30.0,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite),
                      color: Theme.of(context).primaryColor,
                      iconSize: 35.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.restaurant.name,
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '0.2 miles away',
                           style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    RatingStars(widget.restaurant.rating),
                    SizedBox(height: 6.0,),
                    Text(
                      widget.restaurant.address,
                      style: TextStyle(fontSize: 18.0)
                    )
                  ],
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                )
              ),
                onPressed: (){}, 
                child: Text('Reviews', style: TextStyle(fontSize: 20.0, color: Colors.white))
              ),
              TextButton(
                style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                )
              ),
                onPressed: (){}, 
                child: Text('Contact', style: TextStyle(fontSize: 20.0, color: Colors.white))
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Center(
            child: Text('Menu', style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),)
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.all(10.0),
              crossAxisCount: 2,
              children: List.generate(widget.restaurant.menu.length, (index) {
                Food food = widget.restaurant.menu[index];
                return _buildMenuItem(food);
              }),
            ),
          )
        ],
      ),
    );
  }
}