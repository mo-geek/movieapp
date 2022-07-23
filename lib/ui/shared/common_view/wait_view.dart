import 'package:flutter/material.dart';

class WaitForMoments extends StatelessWidget {
  const WaitForMoments({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(bottom: 200),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      SizedBox(
                        height: 25.0,
                      ),
                      Text('wait moments please ... '),
                    ],
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
