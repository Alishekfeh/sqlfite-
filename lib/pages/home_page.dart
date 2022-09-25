import 'package:flutter/material.dart';
import 'package:sq_flite_packege/pages/edit_note.dart';
import '../sql_flite/sql_flite.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;
  List notes = [];

  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM 'notes'");
    notes.addAll(response);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addNotes");
        },
        child: const Icon(Icons.add),
      ),
      body: isLoading == true
          ? const Center(child: Text("Loading ......."))
          : Container(
        padding: const EdgeInsets.all(12),
            child: ListView(
                children: [
                  // MaterialButton(onPressed: ()async{
                  //   await sqlDb.myDeleteDataBase();
                  //   print("كس أمكن");
                  // },
                  //   child: Text('==============d'),
                  // ),
                  // MaterialButton(onPressed: ()async{
                  //  var dd= await sqlDb.readData("SELECT * FROM 'notes'");
                  //   print("كس أمكن");
                  //   print(dd);
                  // },
                  //   child: Text('========================d'),
                  // ),

                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            side:const BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(30),
                          ),

                          child: ListTile(
                              title: Text("${notes[index]['title']}"),
                              subtitle: Text("${notes[index]['note']}"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: ()  {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditNotes(
                                        color: notes[index]['color'],
                                        note: notes[index]['note'],
                                        title: notes[index]['title'],
                                        id: notes[index]['id'],
                                      )));

                                    },
                                    icon: const Icon(Icons.edit),
                                    color: Colors.blue,
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      int response = await sqlDb.deleteData(
                                          "DELETE FROM notes WHERE id =${notes[index]['id']}");
                                      if (response > 0) {
                                        notes.removeWhere((element) =>
                                            element['id'] == notes[index]['id']);
                                        setState(() {});
                                      }
                                    },
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                  ),
                                ],
                              )),
                        );
                      })
                ],
              ),
          ),
    );
  }
}
