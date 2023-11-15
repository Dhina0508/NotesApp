import 'package:flutter/material.dart';
import 'package:notesapp/src/repo/api_service.dart';
import 'package:notesapp/src/provider/notes_provider.dart';
import 'package:notesapp/src/res/color_theme.dart';
import 'package:notesapp/src/views/add_new_notes.dart';
import 'package:notesapp/src/views/search_page.dart';
import 'package:notesapp/src/views/view_notes.dart';
import 'package:notesapp/src/views/widgets/info.dart';
import 'package:notesapp/src/views/widgets/no_notes_found.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  bool isLoading = false;

  List<Color> colors = [
    const Color(0xffFD99FF),
    const Color(0xffFF9E9E),
    const Color(0xff91F48F),
    const Color(0xffFFF599),
    const Color(0xff9EFFFF),
    const Color(0xffB69CFF)
  ];

  Future<void> getData() async {
    isLoading = true;
    setState(() {});
    Provider.of<NoteProvider>(context, listen: false).fetchData().then((value) {
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.apptheme,
        elevation: 0,
        leadingWidth: 150,
        leading: const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Text(
            "Notes",
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 43, color: Colors.white),
          ),
        ),
        actions: [
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchPage()));
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColor.liteblack),
                child: const Center(
                  child: Icon(
                    Icons.search,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: InkWell(
                onTap: () {
                  infoPopup(context);
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColor.liteblack),
                  child: const Center(
                    child: Icon(
                      Icons.info_outline,
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
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : RefreshIndicator(
              onRefresh: getData,
              child: Consumer<NoteProvider>(
                builder: (context, notes, child) => notes.nlm!.data!.isEmpty
                    ? const NoNotesFound()
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: notes.nlm!.data!.length,
                            itemBuilder: (ctx, i) {
                              int j = i;
                              if (j == 6) {
                                j = 0;
                              }

                              return Dismissible(
                                background: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    color: Colors.red,
                                    child: const Icon(Icons.delete,
                                        color: Colors.white, size: 36),
                                  ),
                                ),
                                onDismissed: (val) {
                                  ApiService.deleteData(
                                          notes.nlm!.data![i].id.toString())
                                      .then((value) {
                                    getData();
                                  });
                                },
                                key: const Key("value"),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ViewNotes(
                                                  nm: notes.nlm!.data![i],
                                                )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 12),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: colors[j]),
                                      width: width,
                                      child: Padding(
                                        padding: const EdgeInsets.all(25),
                                        child: Text(
                                          notes.nlm!.data![i].title!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 25,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
              ),
            ),
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
            backgroundColor: AppColor.apptheme,
            elevation: 10,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddNewNotes()));
            },
            child: const Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 48,
              ),
            )),
      ),
    );
  }

  infoPopup(BuildContext context) {
   

    showDialog(
      barrierColor: const Color.fromARGB(84, 130, 128, 128),
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        backgroundColor: AppColor.apptheme,
        content: Info());
      },
    );
  }
}
