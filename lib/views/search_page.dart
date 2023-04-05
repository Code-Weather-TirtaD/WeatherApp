import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/views/home_page.dart';
import '../services/location_service.dart';

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
    searchCity = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Card(
          elevation: 0,
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: TextFormField(
            controller: searchController,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                prefixIcon: IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    onPressed: () {
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage(
                                  lat: -6.3687594, long: 106.8624118)));
                    }),
                suffixIcon: const Icon(Icons.search_rounded)),
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
            return ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: const Text('Find my location'),
                shape: const UnderlineInputBorder(),
                onTap: () async {
                  // Position myLocation = await getCurrentPosition();
                  Position myLocation = await getCurrentPosition();
                  if (kDebugMode) {
                    print(myLocation);
                  }

                  if (myLocation.toJson().isNotEmpty) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                lat: myLocation.latitude,
                                long: myLocation.longitude)));
                  }
                });
          } else {
            return ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: Text(searchController.text));
          }
        },
      ),
    );
  }
}
