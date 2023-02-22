import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  late String searchCity;

  @override
  void initState() {
    // TODO: implement initState
    searchCity = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Card(
          elevation: 0,
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: TextFormField(
            controller: searchController,
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(15),
                suffixIcon: Icon(Icons.search_rounded)),
            onFieldSubmitted: (value) {
              searchController.text = value.toString();
              setState(() {
                searchCity = searchController.text;
              });
            },
          ),
        ),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (searchCity == '') {
            return const ListTile(
              leading: Icon(Icons.location_on_outlined),
              title: Text('Find my location'),
              shape: UnderlineInputBorder(),
            );
          } else {
            return ListTile(
                leading: Icon(Icons.location_on_outlined),
                title: Text(searchController.text));
          }
        },
      ),
    );
  }
}
