import 'package:flutter/material.dart';
import 'package:Friends/pages/home/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			theme: ThemeData.dark(),
			home: HomeView(appTitle: "Friends App",),
			debugShowCheckedModeBanner: false,
		);
	}
}
