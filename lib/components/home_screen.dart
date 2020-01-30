import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20) ),
            child: Container(
              height: MediaQuery.of(context).size.height*(2/5),
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
            ),
          ),

          Container(
            height: MediaQuery.of(context).size.height*(3/5),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    color: Color(0xFFf2f6ff),
                    elevation: 0,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/iron');
                      },
                      child: ListTile(
                        isThreeLine: true,
                        leading: Container(
                          margin: EdgeInsets.all(10),
                            child: Icon(Icons.all_inclusive)
                        ),
                        subtitle: Text('hafhkalfkljsfjfkasfl'),
                        title: Text('Ironing',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight:FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(Icons.navigate_next),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                    ),
                    child: Card(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/wash');
                        },
                        child: ListTile(
                          leading: Icon(Icons.all_inclusive),
                          title: Text('Washing'),
                          trailing: Icon(Icons.navigate_next),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                    ),
                    child: Card(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/dry-clean');
                        },
                        child: ListTile(
                          leading: Icon(Icons.all_inclusive),
                          title: Text('Dry Cleaning'),
                          trailing: Icon(Icons.navigate_next),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}