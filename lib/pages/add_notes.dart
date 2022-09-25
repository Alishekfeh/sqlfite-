// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../sql_flite/sql_flite.dart';
import 'home_page.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formState = GlobalKey();

  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[400],
      appBar: AppBar(
        title: const Text("Add Notes"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Form(
                key: formState,
                child: Column(
                  children: [
                    TextField(
                      controller: title,
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "   title",
                        hintStyle: const TextStyle(color: Colors.white),
                        filled: true,//(0xFFFC6B21//0xFFBC3161
                        fillColor:const Color(0xFF20B9Fc),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: note,
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 60.0),
                        hintText: "   Note",
                        hintStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor:const Color(0xFFFC6B21),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: color,
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "   Color",
                        hintStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Color(0xFFBC3161),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        int response = await sqlDb.insertData(''' 
                         INSERT INTO notes(`note`,`title`,`color`)
                            VALUES ("${note.text}","${title.text}","${color.text}")
                  ''');
                        if (response>0) {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const HomePage()));


                        }
                        print("============================================");
                        print(response);
                      },
                      color: Colors.indigo,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      child:const  Text(
                        "Add Text",
                        style: TextStyle(fontSize: 22),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
