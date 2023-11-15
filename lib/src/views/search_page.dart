import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:notesapp/src/models/notes_model.dart';
import 'package:notesapp/src/provider/notes_provider.dart';
import 'package:notesapp/src/res/color_theme.dart';
import 'package:notesapp/src/views/view_notes.dart';
import 'package:notesapp/src/views/widgets/search_not_found.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 36),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: TypeAheadField<NotesModel>(
                  suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                    color: AppColor.apptheme,
                  ),
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _searchController,
                    style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                        color: Colors.white),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 20),
                        fillColor: AppColor.liteblack,
                        filled: true,
                        hintText: "Search by the keyword...",
                        suffixIcon: InkWell(
                          onTap: () {
                            _searchController.text = "";
                          },
                          child: const Icon(
                            Icons.close,
                            size: 20,
                            color: Color(0xffCCCCCC),
                          ),
                        ),
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Color(0xffCCCCCC)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  noItemsFoundBuilder: (val) {
                    return const SearchNotFound();
                  },
                  suggestionsCallback: (pattern) async {
                    return Provider.of<NoteProvider>(context, listen: false)
                        .nlm!
                        .data!
                        .where((item) => item.title!
                            .toLowerCase()
                            .contains(pattern.toLowerCase()))
                        .toList();
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(
                        suggestion.title!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewNotes(nm: suggestion)));
                  },
                ),
              )
            
            ],
          ),
        ),
      ),
    );
  }
}
