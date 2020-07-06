import 'package:flutter/material.dart';
import 'package:Friends/models/user.dart';

class UserCard extends StatelessWidget {
	final User user;
	final Function onUserClicked;

	UserCard({this.user, this.onUserClicked});

	@override
	Widget build(BuildContext context) {
		return GestureDetector(
			onTap: (){
				if(this.onUserClicked != null)
					this.onUserClicked(user);
			},
			child: Card(
				elevation: 4.0,
				child: ClipRRect(
					borderRadius: BorderRadius.circular(10.0),
					child: Container(
						color: Colors.white,
						width: 200,
						height: 320,
						child: Column(
							mainAxisAlignment: MainAxisAlignment.center,
							mainAxisSize: MainAxisSize.max,
							children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 6.0)),
								ClipRRect(
									borderRadius: BorderRadius.circular(10.0),
									child: user.img == null ? FadeInImage.assetNetwork(
										placeholder: "assets/images/profile_waiting.png",
										image: user.img != null ? user.img.path : "assets/images/profile_waiting.png",
										height: 120.0,
									):
									Image.file(user.img,height: 120.0,),
								),
								Padding(padding: EdgeInsets.only(top: 6.0)),
								Text(
									user.name,
									style: TextStyle(
										color: Colors.black,
									),
								),
								Padding(padding: EdgeInsets.all(2.0)),
								Text(
									user.jobDescription,
									style: TextStyle(
										color: Colors.black,
									),
								),
							],
						),
					),
				)
			),
		);
	}
}
