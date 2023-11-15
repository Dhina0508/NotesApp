import 'package:flutter/material.dart';
import 'package:notesapp/src/models/notes_model.dart';
import 'package:notesapp/src/res/color_theme.dart';
import 'package:notesapp/src/views/add_new_notes.dart';

class ViewNotes extends StatefulWidget {
  const ViewNotes({super.key, required this.nm});
  final NotesModel nm;

  @override
  State<ViewNotes> createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> {
  @override
  void initState() {
    super.initState();
    setData();
  }

  setData() {
    titleController.text = widget.nm.title!;
    messageController.text = widget.nm.description!;
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.apptheme,
          elevation: 0,
          leadingWidth: 70,
          leading: Padding(
            padding: const EdgeInsets.only(left: 23),
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                      color: AppColor.liteblack,
                      borderRadius: BorderRadius.circular(15)),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddNewNotes(
                                  isFromEdit: true,
                                  nm: widget.nm,
                                )));
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColor.liteblack),
                    child: const Center(
                      child: Icon(
                        Icons.edit_outlined,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
              child: Column(
                children: [
                  TextField(
                    enabled: false,
                    controller: titleController,
                    maxLines: 4,
                    minLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 35,
                        color: Colors.white),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    )),
                  ),
                  TextField(
                    enabled: false,
                    controller: messageController,
                    maxLines: 20,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 23,
                        color: Colors.white),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    )),
                  ),
                ],
              )),
        ));
  }
}
