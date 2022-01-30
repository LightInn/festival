import 'package:flutter/material.dart';

class OptionsCrudPage extends StatelessWidget {
  const OptionsCrudPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(
            flex: 2,
          ),
          ElevatedButton(onPressed: () => {}, child: Text("Festivals")),
          ElevatedButton(onPressed: () => {}, child: Text("Stands")),
          ElevatedButton(onPressed: () => {}, child: Text("Passages")),
          ElevatedButton(onPressed: () => {}, child: Text("Artiste")),
          ElevatedButton(onPressed: () => {}, child: Text("User")),
          Spacer(
            flex: 2,
          ),
          ElevatedButton(
              onPressed: () =>
                  {Navigator.of(context).pushReplacementNamed("/home")},
              child: Text("Menu")),
        ],
      ),
    );
  }
}
