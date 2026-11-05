import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_project/view_data.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void>insertrecord() async{

    if(name.text != "" || email.text != ""|| password.text != "") {
      try {


        String uri = "http://192.168.29.190/practice_api/insert_record.php";

        var res = await http.post(Uri.parse(uri),body: {

          "name": name.text,
          "email":email.text,
          "password":password.text
        });

        var response = jsonDecode(res.body);
        if(response["success"] == "true")
          {
            print("Record Inserted");
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Record Inserted Successfully!")),);

            name.text ="";
            email.text="";
            password.text="";

          }else{
          print("Not Inserted");
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to Insert Record!"),));
        }


      }
      catch (e) {
        print(e);
      }
    }else{
      print("please fill All fields ");
      ScaffoldMessenger.of(context).showSnackBar
        (SnackBar(content: Text("Please Fill ALl Fields"),)
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return
     Scaffold(appBar: AppBar(title: Text('Insert Record'),),
          body: Column(children: [
            Container(margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(), label: Text('Enter the Name')),
              ),
            ),

            Container(margin: EdgeInsets.all(10),
              child: TextFormField(
                  controller: email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('Enter the Email')),
              ),
            ),
            Container(margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: password,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('Enter the Password')),
              ),
            ),

            Container(
              margin: EdgeInsets.all(15),
              child: ElevatedButton(onPressed:() {insertrecord();},
                  child: Text('Insert'),),
            ),

            Container(
              margin: EdgeInsets.all(10),
              child: Builder(
                  builder: (context){
                    return ElevatedButton(onPressed: () { // To open new page -----
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => view_data()));
                    }, child:Text("View Data"));
                  }),
            )


          ],)
    );
  }

}