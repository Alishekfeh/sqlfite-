// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../sql_flite/sql_flite.dart';
import 'home_page.dart';

class EditNotes extends StatefulWidget {
  final String note;
  final String title;
  final int  id;
  final String color;

  const EditNotes({Key? key, required this.note, required this.title, required this.id, required this.color})
      : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formState = GlobalKey();

  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[400],
      appBar: AppBar(
        title: const Text("Edit Notes"),
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
                        filled: true,
                        fillColor: Colors.blueAccent[100],
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
                        fillColor: Colors.grey[300],
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
                        fillColor: Colors.blueAccent[100],
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () async  {
                        // int response = await sqlDb.updateData('''
                        //   UPDATE notes SET
                        //  note ="${note.text}",
                        //  title ="${title.text}",
                        //  color ="${color.text}"
                        // WHERE id =${widget.id},
                        //    ''');

                        int response=await sqlDb.update("notes", {
                          "note":note.text,
                          "color":color.text,
                          "title":title.text,
                        }, "id=${widget.id}");
                        print("============================================");
                        print(response);
                        if (response > 0) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),(rout)=>false);
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
                      child: const Text(
                        "Edit Text ",
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
