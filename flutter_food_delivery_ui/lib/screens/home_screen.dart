
import 'package:app/data/data.dart';
import 'package:app/models/restaurant.dart';
import 'package:app/screens/cart_screen.dart';
import 'package:app/screens/restaurant_screen.dart';
import 'package:app/widgets/rating_stars.dart';
import 'package:app/widgets/recent_orders.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  _buildRestaurants(){
    List<Widget> restaurantList = [];
    restaurants.forEach((Restaurant restaurant){
      restaurantList.add(
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RestaurantScreen(restaurant: restaurant),
            ),
          ),
          child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0,),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              width: 1.0,
              color: Color.fromARGB(255, 242, 241, 241),
            )
          ),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Hero(
                  tag: restaurant.imageUrl,
                  child: Image(image: AssetImage(restaurant.imageUrl),
                    height: 150.0,
                    width: 150.0,
                    fit: BoxFit.cover,),
                ),
              ),
              Container(
                margin: EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(restaurant.name, style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    ),
                    overflow: TextOverflow.ellipsis,),
                    SizedBox(height: 0.4),
                    RatingStars(restaurant.rating), 
                    Text(restaurant.address, style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600
                    ), overflow: TextOverflow.ellipsis,),
                    SizedBox(height: 0.4),
                    Text('0.2 miles away', style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600
                    ), overflow: TextOverflow.ellipsis,),
                  ],
                ),
              ),
            ],
          ),
          ),
        ));
    });
    return Column(
      children: restaurantList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
          leading: IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: (){},
            iconSize: 30.0,
          ),
        title:Align(
          child: Text('Food Delivery'),
            alignment: Alignment.center
        ),
        actions: <Widget> [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white, minimumSize: Size(88, 36),
            ),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen(),),),
            child: Text('Cart (${currentUser.cart.length})'),
          )]
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(width: 0.8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(width: 0.8, color: Theme.of(context).primaryColor),
                ),
                hintText: 'Search Food or Restaurant',
                prefixIcon: Icon(
                  Icons.search,
                  size: 30.0,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: (){},
                )
              ),
            ),
          ),
          RecentOrder(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('Nearby Restaurants',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2
                    ),
                ),
              ),
              _buildRestaurants(),
            ],
          )
        ],
      ),
    );
  }
}
