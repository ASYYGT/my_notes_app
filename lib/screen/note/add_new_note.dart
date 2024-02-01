import 'package:daily_app/data/db_note_helper.dart';
import 'package:daily_app/extension.dart';
import 'package:daily_app/models/check_box_model.dart';
import 'package:daily_app/models/note_model.dart';
import 'package:daily_app/screen/login/login_screen.dart';
import 'package:flutter/material.dart';

class AddNewNote extends StatefulWidget {
  final NoteModel note;
  const AddNewNote({super.key, required this.note});

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  CustomCheckBoxModel selectImportant = CustomCheckBoxModel();
  DbNoteHelper noteHelper = DbNoteHelper();
  @override
  void initState() {
    selectImportant = checkBoxList[widget.note.materialityId];
    titleController.text = widget.note.title.toString();
    valueController.text = widget.note.value.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.largAutoText(
            widget.note.id != -1 ? "Edit Note" : "Add Note", Colors.white),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
      ),
      bottomNavigationBar: TextButton(
        onPressed: () {
          if (widget.note.id == -1) {
            noteHelper
                .insertNote(NoteModel(
                    id: widget.note.id,
                    materialityId: selectImportant.id,
                    title: titleController.text,
                    value: valueController.text))
                .then((value) {
              Navigator.pop(context);
            });
          } else {
            noteHelper
                .updateNote(NoteModel(
                    id: widget.note.id,
                    materialityId: selectImportant.id,
                    title: titleController.text,
                    value: valueController.text))
                .then((value) {
              Navigator.pop(context);
            });
          }
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          foregroundColor: Colors.green,
          backgroundColor: Colors.greenAccent.shade700,
        ),
        child: context.middleAutoText("Kaydet", Colors.white),
      ),
      body: Padding(
        padding: context.dynamicAllPadding(0.01, 0.02),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          DropdownButton<CustomCheckBoxModel>(
            value: selectImportant,
            isExpanded: true,
            style: TextStyle(color: Theme.of(context).primaryColorDark),
            onChanged: (val) {
              setState(() {
                selectImportant = val!;
              });
            },
            icon: const Icon(
              Icons.arrow_downward,
              color: Colors.white,
            ),
            underline: Container(
              height: 2,
              color: Colors.white,
            ),
            items: checkBoxList.map((items) {
              return DropdownMenuItem<CustomCheckBoxModel>(
                value: items,
                child:
                    context.middleAutoText(items.name.toString(), Colors.white),
              );
            }).toList(),
          ),
          SizedBox(
            height: context.dynamicHeight(0.01),
          ),
          TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: selectImportant.borderColor!),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: selectImportant.borderColor!, width: 2),
                  borderRadius: BorderRadius.circular(15)),
              hintText: "Title",
              hintStyle: TextStyle(
                  color: selectImportant.borderColor!,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
              filled: true,
              fillColor: selectImportant.boxColor!,
            ),
            style: const TextStyle(color: Colors.white),
            controller: titleController,
          ),
          SizedBox(
            height: context.dynamicHeight(0.01),
          ),
          Expanded(
            child: TextField(
              controller: valueController,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: selectImportant.borderColor!),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: selectImportant.borderColor!, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                hintText: "Not",
                hintStyle: TextStyle(
                    color: selectImportant.borderColor!,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
                filled: true,
                fillColor: selectImportant.boxColor!,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
