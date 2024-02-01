import 'package:daily_app/data/db_note_helper.dart';
import 'package:daily_app/models/check_box_model.dart';
import 'package:daily_app/models/note_model.dart';
import 'package:daily_app/screen/menu/menu_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

List<CustomCheckBoxModel> checkBoxList = [
  CustomCheckBoxModel(
      id: 0,
      boxColor: Colors.blueGrey,
      borderColor: Colors.blueGrey.shade700,
      isActive: true,
      name: "UnimportantNote"),
  CustomCheckBoxModel(
      id: 1,
      boxColor: Colors.blueAccent,
      borderColor: Colors.blueAccent.shade700,
      isActive: true,
      name: "NormalNote"),
  CustomCheckBoxModel(
      id: 2,
      boxColor: Colors.orangeAccent,
      borderColor: Colors.orangeAccent.shade700,
      isActive: true,
      name: "ImportantNote"),
  CustomCheckBoxModel(
      id: 3,
      boxColor: Colors.redAccent,
      borderColor: Colors.redAccent.shade700,
      isActive: true,
      name: "VeryImportantNote"),
  CustomCheckBoxModel(
      id: 4,
      boxColor: Colors.purpleAccent,
      borderColor: Colors.purpleAccent.shade700,
      isActive: true,
      name: "CriterialNote")
];

class _LoginScreenState extends State<LoginScreen> {
  List<NoteModel> noteList = [];
  DbNoteHelper noteHelper = DbNoteHelper();

  @override
  void didChangeDependencies() {
    noteHelper.getNotes().then((value) {
      noteList = value;
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MenuScreen(
                  noteList: noteList,
                )));
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        "assets/login_screen.png",
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
