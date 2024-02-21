import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data =
        data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>? ??
            {};
    print(data);

    // set background
    String image = data['isDayTime'] ? 'dayy.jpg' : 'nightt.jpg';
    Color? color = data['isDayTime'] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: color,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/$image'),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 128.0, 0, 0),
            child: Column(
              children: [
                TextButton(
                    onPressed: () async{
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time':result['time'],
                          'location':result['location'],
                          'isDayTime':result['isDayTime'],
                          'flag':result['flag']
                        };
                      });
                    },
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.edit_location,
                          color:  Colors.grey[300],
                        ),
                        Text(
                          'Edit location',
                          style: TextStyle(color: Colors.grey[300]),
                        )
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: Colors.white),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(data['time'],
                    style: TextStyle(fontSize: 66.0, color: Colors.white))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
