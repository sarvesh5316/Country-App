import 'package:country_app/presentation/widgets/country_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_app/logic/bloc/countrybloc/country_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: SizedBox(
          height: 50,
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchText = value.toLowerCase();
              });
            },
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search Your Country Here..',
              hintStyle: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'Times New Roman',
                  color: Colors.white),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.white)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.white)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.white)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.white)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.white)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.white)),
              suffixIcon: IconButton(
                onPressed: () {
                  searchController.clear();
                  setState(() {
                    searchText = '';
                  });
                },
                icon: const Icon(Icons.search, color: Colors.white),
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: BlocBuilder<CountryBloc, CountryState>(
        builder: (context, state) {
          if (state is CountryLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CountryLoadedState) {
            // Filter the country list based on the search query
            final filteredList = state.countryList
                .where((country) =>
                    country.nameCommon.toLowerCase().contains(searchText))
                .toList();

            return ListView.builder(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final country = filteredList[index];
                return ListTile(
                  title: Text(
                    country.nameCommon,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Times New Roman',
                        overflow: TextOverflow.ellipsis),
                  ),
                  subtitle: Text(
                    country.capital,
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Times New Roman',
                        overflow: TextOverflow.ellipsis),
                  ),
                  trailing: const Icon(Icons.arrow_forward),
                  // You can add more information about the country here
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => CountryWidget(
                            countryModel: state.countryList[index]));
                    // Handle country tap
                  },
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
/*
TextField(
            controller: searchController,
            onChanged: (value) {
              setState(() {
                searchText = value.toLowerCase();
              });
            },
            decoration: InputDecoration(
              hintText: 'Search Your Country Here..',
              hintStyle: const TextStyle(
                fontSize: 15,
                fontFamily: 'Times New Roman',
                color: Colors.white,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.white),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  searchController.clear();
                  setState(() {
                    searchText = '';
                  });
                },
                icon: const Icon(Icons.clear, color: Colors.white),
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),*/