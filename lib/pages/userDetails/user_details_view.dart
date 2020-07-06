import 'package:flutter/material.dart';
import 'package:Friends/models/user.dart';
import 'package:Friends/components/user_card.dart';

class UserDetailsView extends StatelessWidget {
	final User selectedUser;
	UserDetailsView({this.selectedUser});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text("${selectedUser.name}'s Details"),
				leading: IconButton(
					icon: Icon(Icons.keyboard_arrow_left), 
					onPressed: (){
						Navigator.of(context).pop();
					}
				),
			),
			body: Center(
				child: Column(
					children: <Widget>[
						Padding(
							padding: EdgeInsets.all(40.0)
						),
						UserCard(
							user: selectedUser,
						),
						FlatButton(
							onPressed: (){
								Navigator.of(context).pop({"deleteUser":true});
							},
							color: Colors.red,
							textColor: Colors.white,
							child: Text("delete"),
						)
					],
				),
			),
		);
	}
}