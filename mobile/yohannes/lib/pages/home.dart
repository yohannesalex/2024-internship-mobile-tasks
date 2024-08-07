import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widget/card.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _date ;
  @override
  void initState() {
    super.initState();
    _updateDate();
  }

  void _updateDate() {
    final now = DateTime.now();
    setState(() {
      _date = DateFormat('MMMM d, yyyy').format(now);
    });
    // Update time every second
    Future.delayed(const Duration(seconds: 1), _updateDate);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
      SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [

              Container(
              width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10.0),)),
                      const SizedBox(width: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _date,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                          ),
                          const Row(
                            children: [
                              Text("Hello,  "),
                              Text("Yohannes" , style: TextStyle(fontWeight: FontWeight.bold),)
                            ],
                          )
                        ],
        
                      )
                    ],
                  ),
                  Container(
                      padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey, // Border color
                        width: 1.0, // Border width
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),

                      child: const Icon(Icons.notifications_on_outlined),
                  )
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Avaliable Products", style: TextStyle(fontWeight: FontWeight.bold, fontSize:25),),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey, // Border color
                        width: 1.0, // Border width
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),

                    child: const Icon(Icons.search , color: Colors.grey,),
                  )
                ],
              ),
              const SizedBox(height: 25,),
        
              p.displayCard(),
              p.displayCard(),
              p.displayCard(),
              p.displayCard(),
              p.displayCard()
        
        
        
            ],
        
          ),
        
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {  },
        backgroundColor: const Color(0xFF3F51F3),
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );

  }
}


