import 'package:flutter/material.dart';
import 'package:Friends/models/user.dart';
import 'package:Friends/components/user_card.dart';
import 'package:Friends/pages/userDetails/user_details_view.dart';
import 'package:Friends/pages/add/add_user_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget{
	final String appTitle;

	HomeView({this.appTitle});

	@override
	State<StatefulWidget> createState() {
		return _HomeViewState();
	}
}

class _HomeViewState extends State<HomeView>{
	List<User> _usersList;

	@override
	void initState(){
		super.initState();
		_usersList = [
			// User(
			// 	id:"1", 
			// 	name:"Antoin", 
			// 	jobDescription: "ITI std", 
			// 	//img: "https://scontent-hbe1-1.xx.fbcdn.net/v/t1.0-9/72471360_910044496063236_3553970431100715008_n.jpg?_nc_cat=104&_nc_sid=09cbfe&_nc_ohc=d0Zy_WHeTykAX-tQxhH&_nc_ht=scontent-hbe1-1.xx&oh=a78511b7884dd8500d703596bb77d57e&oe=5EF32A5E"
			// ),
			// User(
			// 	id:"3", 
			// 	name:"Boula", 
			// 	jobDescription: "Helwan Std", 
			// 	//img: "https://scontent-hbe1-1.xx.fbcdn.net/v/t1.0-9/91562148_1553007554863337_5786096537201278976_n.jpg?_nc_cat=109&_nc_sid=09cbfe&_nc_ohc=Ai5JXV1jA7MAX8MBgV9&_nc_ht=scontent-hbe1-1.xx&oh=eff5e0c9c2ab94c1ac40b5e1a33a2cd8&oe=5EF3C8F3"
			// ),
			// User(
			// 	id:"2", 
			// 	name:"Amani", 
			// 	jobDescription: "ITI Std", 
			// 	//img: "https://scontent-hbe1-1.xx.fbcdn.net/v/t1.0-9/99156872_2929108643872728_8512315951616622592_n.jpg?_nc_cat=100&_nc_sid=09cbfe&_nc_ohc=haM1w9FGhQYAX8Vm9BP&_nc_ht=scontent-hbe1-1.xx&oh=9e853ab840d10601d93299b9d7386b61&oe=5EF4AEDC"
			// ),
			// User(
			// 	id:"3", 
			// 	name:"Mariam", 
			// 	jobDescription: "ITI std", 
			// 	//img: "https://scontent-hbe1-1.xx.fbcdn.net/v/t1.0-9/98161528_2827842054112173_5598644244345520128_o.jpg?_nc_cat=109&_nc_sid=09cbfe&_nc_ohc=DSkvfoNJS9kAX9KEo2e&_nc_ht=scontent-hbe1-1.xx&oh=9cbed0ba3881d377c95472d7b34f9310&oe=5EF2E549"
			// ),
			// User(
			// 	id:"3", 
			// 	name:"Mohamed Ali", 
			// 	jobDescription: "ITI std", 
			// 	//img: "https://scontent-hbe1-1.xx.fbcdn.net/v/t1.0-9/78482112_3073099126052090_1600171683388325888_o.jpg?_nc_cat=106&_nc_sid=174925&_nc_ohc=MGG7yjl6sqAAX-Hd3OE&_nc_ht=scontent-hbe1-1.xx&oh=d158b0e137588b977389bff2bc5a6e4f&oe=5EF258A1"
			// ),
		];
	}

	List<Widget> _getUsersCards(){
		List<Widget> usersCards = [];
		_usersList.forEach( 
			(user) => usersCards.add(UserCard(
				user: user,
				onUserClicked: _onUserClicked,
			) )
		);
		return usersCards;
	}

	void _onAddUserClicked() async{
		Map result = await Navigator.of(context).push(
			MaterialPageRoute(
				builder: (context) => AddUserView()
			)
		);
		if(result != null && result['newUser'] != null){
			if(_usersList.length > 0)
				result['newUser'].id = (int.parse(_usersList.last.id)+1).toString();
			else
				result['newUser'].id = "1";
			setState(() {
				_usersList.add(result['newUser']);
			});
		}
	}

	void _onUserClicked(User selectedUser) async {
		//print("clicked user form chiled ${selectedUser.name}");
		Map result = await Navigator.of(context).push(
			MaterialPageRoute(
				builder: (context)=> UserDetailsView(
					selectedUser: selectedUser,
				),
			)
		);

		if(result != null && result['deleteUser']){
			setState(() {
				_usersList.removeWhere((user)=> user.id == selectedUser.id);
			});
		}
	}

	Widget _getHomeWidget() {
		return Scaffold(
			appBar: AppBar(
				title: Text(widget.appTitle),
				elevation: 5.0,
				centerTitle: false,
				leading: Icon(Icons.home),
				actions: <Widget>[
					IconButton(
						icon: Icon(Icons.add),
						onPressed: () {
							_onAddUserClicked();
						}
					),
				],
			),
			body: Padding(
				padding: EdgeInsets.all(6.0),
				child: GridView.extent(
					maxCrossAxisExtent: 250.0,
					children: _getUsersCards(),
					mainAxisSpacing: 2.0,
					crossAxisSpacing: 1.0,
				),
			)
		);
	}

	@override
	Widget build(BuildContext context) {
		return _getHomeWidget();
	}
}