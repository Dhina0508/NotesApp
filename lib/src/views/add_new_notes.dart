// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:notesapp/src/models/notes_model.dart';
import 'package:notesapp/src/repo/api_service.dart';
import 'package:notesapp/src/res/color_theme.dart';
import 'package:notesapp/src/views/home_page.dart';

class AddNewNotes extends StatefulWidget {
  const AddNewNotes({super.key, this.isFromEdit = false, this.nm});
  final bool isFromEdit;
  final NotesModel? nm;

  @override
  State<AddNewNotes> createState() => _AddNewNotesState();
}

class _AddNewNotesState extends State<AddNewNotes> {
  @override
  void initState() {
    super.initState();
    setData();
  }

  setData() {
    if (widget.isFromEdit == true) {
      titleController.text = widget.nm!.title!;
      messageController.text = widget.nm!.description!;
    }
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
              child: GestureDetector(
                onTap: () {
                  backpopup(context);
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
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: AppColor.liteblack,
                      borderRadius: BorderRadius.circular(15)),
                  child: const Center(
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: GestureDetector(
                  onTap: () {
                    savepopup(context);
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColor.liteblack),
                    child: const Center(
                      child: Icon(
                        Icons.save_outlined,
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    maxLines: 4,
                    minLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 48,
                        color: Colors.white),
                    decoration: const InputDecoration(
                        hintText: "Title",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 48,
                            color: Color(0xff9A9A9A)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        )),
                  ),
                  TextField(
                    controller: messageController,
                    maxLines: 15,
                    minLines: 1,
                    autofocus: widget.isFromEdit == true ? true : false,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 23,
                        color: Colors.white),
                    decoration: const InputDecoration(
                        hintText: "Type Something...",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 23,
                            color: Color(0xff9A9A9A)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        )),
                  ),
                ],
              )),
        ));
  }
  
  savepopup(BuildContext context) {
    Widget discardButton = Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        height: 38,
        width: 112,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Discard",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            )),
      ),
    );
    Widget saveButton = Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 38,
        width: 112,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            onPressed: () {
              if (titleController.text != "" && messageController.text != "") {
                if (widget.isFromEdit) {
                  ApiService.updateData(
                      widget.nm!.id!.toString(),
                      {
                        "title": titleController.text,
                        "description": messageController.text
                      },
                      context);
                } else {
                  ApiService.postData({
                    "title": titleController.text,
                    "description": messageController.text
                  }, context);
                }
              }
            },
            child: const Text(
              "Save",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            )),
      ),
    );

    AlertDialog save = AlertDialog(
      insetPadding: const EdgeInsets.all(2),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      backgroundColor: AppColor.apptheme,
      title: const Center(
        child: Icon(
          Icons.info,
          size: 36,
          color: Color(0xff606060),
        ),
      ),
      content: const Text(
        "Save changes ?",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 23,
            color: Color(0xffCFCFCF)),
      ),
      actions: [
        discardButton,
        saveButton,
      ],
    );

    showDialog(
      barrierColor: const Color.fromARGB(84, 130, 128, 128),
      context: context,
      builder: (BuildContext context) {
        return save;
      },
    );
  }

  backpopup(BuildContext context) {
    Widget discardButton = Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        height: 38,
        width: 112,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
          context,
          (MaterialPageRoute(builder: (context) => const Homepage())),
          (route) => false);
            },
            child: const Text(
              "Discard",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            )),
      ),
    );
    Widget saveButton = Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 38,
        width: 112,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Keep",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            )),
      ),
    );

    AlertDialog save = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      backgroundColor: AppColor.apptheme,
      title: const Center(
        child: Icon(
          Icons.info,
          size: 36,
          color: Color(0xff606060),
        ),
      ),
      content: const Text(
        "Are your sure you want discard your changes ?",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 23,
            color: Color(0xffCFCFCF)),
      ),
      actions: [
        discardButton,
        saveButton,
      ],
    );

    showDialog(
      barrierColor: const Color.fromARGB(84, 130, 128, 128),
      context: context,
      builder: (BuildContext context) {
        return save;
      },
    );
  }

}
