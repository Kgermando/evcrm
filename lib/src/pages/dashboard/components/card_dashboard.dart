import 'package:flutter/material.dart';

class CardDashboard extends StatelessWidget {
  const CardDashboard({Key? key, required this.typeCall, required this.nbreCall, required this.icon, required this.color}) : super(key: key);
  final String typeCall;
  final int nbreCall;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Card(
      elevation: 10,
      child: SizedBox(
        height: 100,
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(icon, color: color),
                Text(nbreCall.toString(), style: const TextStyle(fontSize: 20.0),),
              ],
            ),
            Text(
              typeCall,
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}

class CardDashboard1 extends StatelessWidget {
  const CardDashboard1({
    Key? key, required this.typeCall, 
    required this.nbreCall, 
    required this.icon, 
    required this.color}) : super(key: key);

  final String typeCall;
  final int nbreCall;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: SizedBox(
        height: 100,
        width: 210,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  nbreCall.toString(),
                  style: const TextStyle(fontSize: 30.0),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(icon, color: color, size: 40.0,),
                    const SizedBox(height: 10.0,),
                    Text(
                      typeCall,
                      style: const TextStyle(fontSize: 12.0),
                    ),
                  ],
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}