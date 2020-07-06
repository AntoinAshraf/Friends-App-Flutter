import 'dart:io';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:Friends/models/user.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:path_provider/path_provider.dart';

class AddUserView extends StatefulWidget {
	
	@override
	_AddUserViewState createState() => _AddUserViewState();
}

class _AddUserViewState extends State<AddUserView> {

	User _newUser;
	FocusNode nameNode, descNode;

	Future getImage() async {
		var image = await ImagePicker.pickImage(source: ImageSource.gallery);
		setState(() {
			_newUser.img = image;
		});
	}

	@override
	void initState() {
		super.initState();
		_newUser = new User(name: "", jobDescription: "");
		nameNode = FocusNode(); 
		descNode = FocusNode();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text("Add User"),
				elevation: 5.0,
				centerTitle: false,
			),
			body: Center(
				child: Form(
					child: Column(
						children: <Widget>[
							Padding(
								padding: EdgeInsets.symmetric(horizontal: 10),
								child: TextFormField(
									focusNode: nameNode,
									textInputAction: TextInputAction.next,
									initialValue: _newUser.name,
									decoration: InputDecoration(
										hintText: 'Name',
									),
									style: TextStyle(fontSize: 25),
									onChanged: (String value){
										setState(() {
											_newUser.name = value;
											print(_newUser.name);
										});
									},
									onFieldSubmitted: (String value){
										setState(() {
											_newUser.name = value;
											print(_newUser.name);
										});
										FocusScope.of(context).requestFocus(descNode);
									},
								),
							),
							Padding(
								padding: EdgeInsets.all(3.0)
							),
							Padding(
								padding: EdgeInsets.symmetric(horizontal: 10),
								child: TextFormField(
									focusNode: descNode,
									textInputAction: TextInputAction.done,
									initialValue: _newUser.jobDescription,
									decoration: InputDecoration(
										hintText: 'Desciption',
									),
									style: TextStyle(fontSize: 25),
									onChanged: (String value){
										setState(() {
											_newUser.jobDescription = value;
											print(_newUser.jobDescription);
										});
									},
									onFieldSubmitted: (String value){
										setState(() {
											_newUser.jobDescription = value;
											print(_newUser.jobDescription);
										});
									},
								),
							),
							Padding(
								padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
								child: _newUser.img == null
									? Text(
										'press the button at the bottom of the screen to select image', 
										textAlign: TextAlign.center,
									)
									: Image.file(_newUser.img, height: 300),
							),
							Padding(
								padding: EdgeInsets.all(16.0),
								child: FlatButton(
									onPressed: (){
										if(_newUser.name == "" || _newUser.name == null || _newUser.jobDescription == "" || _newUser.name == null){
											Toast.show("some values are missing", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
										}
										else
											Navigator.of(context).pop({"newUser":_newUser});
									},
									color: Colors.blue,
									textColor: Colors.white,
									child: Text("Add Friend")
								),
							)
						],
					),
				),
			),
			floatingActionButton: FloatingActionButton(
				onPressed: getImage,
				tooltip: 'Pick Image',
				child: Icon(Icons.add_a_photo),
			),
		);
	}
}
