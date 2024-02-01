import 'package:auto_size_text/auto_size_text.dart';
import 'package:daily_app/data/db_note_helper.dart';
import 'package:daily_app/extension.dart';
import 'package:daily_app/models/note_model.dart';
import 'package:daily_app/screen/login/login_screen.dart';
import 'package:daily_app/screen/note/add_new_note.dart';
import 'package:daily_app/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MenuScreen extends StatefulWidget {
  final List<NoteModel> noteList;
  const MenuScreen({super.key, required this.noteList});
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  DbNoteHelper noteHelper = DbNoteHelper();
  List<NoteModel> newNoteList = [];

  void addNewNote() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddNewNote(
                  note:
                      NoteModel(id: -1, materialityId: 0, title: "", value: ""),
                ))).then((value) {
      noteHelper.getNotes().then((value) {
        setState(() {
          newNoteList = value;
        });
      });
    });
  }

  void editNote(int index) {
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddNewNote(note: newNoteList[index])))
        .then((value) {
      noteHelper.getNotes().then((value) {
        setState(() {
          newNoteList = value;
        });
      });
    });
  }

  void deleteNote(int index) {
    Navigator.pop(context);
    loadingAlert(context);
    noteHelper.deleteNote(newNoteList[index].id).then((value) {
      noteHelper.getNotes().then((value) {
        setState(() {
          newNoteList = value;
          Navigator.pop(context);
        });
      });
    });
  }

  @override
  void initState() {
    newNoteList = widget.noteList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey,
          onPressed: () {
            addNewNote();
          },
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )),
      appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const AutoSizeText("MYNOTES")),
      body: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            for (var index in checkBoxList)
              Checkbox(
                  value: index.isActive,
                  checkColor: index.boxColor,
                  activeColor: index.boxColor,
                  side: BorderSide(color: index.borderColor!, width: 2),
                  onChanged: (value) {
                    setState(() {
                      index.isActive = !index.isActive!;
                    });
                  }),
          ]),
          Flexible(
            child: MasonryGridView.count(
                crossAxisCount: 2,
                itemCount: newNoteList.length,
                itemBuilder: (context, index) {
                  List<String> lines =
                      newNoteList[index].value.toString().split('\n');
                  int ht = lines.length < 4
                      ? ((newNoteList[index].value.length % 5) + 1)
                      : 4;
                  return checkBoxList[newNoteList[index].materialityId]
                              .isActive ==
                          true
                      ? Padding(
                          padding: context.dynamicAllPadding(0.01, 0.02),
                          child: InkWell(
                            onLongPress: () {
                              selectedItemBottomSheet(context, index);
                            },
                            child: notesContainerBuild(index, ht),
                          ),
                        )
                      : const SizedBox();
                }),
          ),
        ],
      ),
    );
  }

  Widget notesContainerBuild(int index, int ht) {
    return InkWell(
      onTap: () {
        editNote(index);
      },
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color:
                    checkBoxList[newNoteList[index].materialityId].borderColor!,
                width: 2),
            color: checkBoxList[newNoteList[index].materialityId].boxColor,
            borderRadius: context.borderRadiusValue,
            boxShadow: [
              BoxShadow(
                color: checkBoxList[newNoteList[index].materialityId]
                    .boxColor!
                    .withOpacity(1),
                blurRadius: 8.0,
                spreadRadius: 3.0,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: context.dynamicAllPadding(0.01, 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                context.middleTitleAutoText(
                    newNoteList[index].title.toString(), Colors.white),
                const Divider(
                  color: Colors.white,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: context.lowAutoText(
                      newNoteList[index].value.toString(), Colors.white, ht),
                )
              ],
            ),
          )),
    );
  }

  Future<void> selectedItemBottomSheet(BuildContext context, int index) {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.005),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    label: context.middleAutoText("Edit", Colors.white),
                    style:
                        TextButton.styleFrom(alignment: Alignment.centerLeft),
                    onPressed: () {
                      Navigator.pop(context);
                      editNote(index);
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    label: context.middleAutoText("Delete", Colors.white),
                    style:
                        TextButton.styleFrom(alignment: Alignment.centerLeft),
                    onPressed: () {
                      deleteNote(index);
                    },
                  ),
                ),
                Divider(
                  color: Colors.grey.shade500,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ));
      },
    );
  }
}
