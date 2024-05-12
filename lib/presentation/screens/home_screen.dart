import 'package:country_app/presentation/screens/search_screen.dart';
import 'package:country_app/presentation/widgets/groupWidgets/group_grid_widget.dart';
import 'package:country_app/presentation/widgets/groupwidgets/const.dart';
import 'package:country_app/presentation/widgets/sorting_grouping_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../data/functions/functions.dart';
import '../../data/models/country_model.dart';
import '../../logic/bloc/countrybloc/country_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CountryBloc>(context).add(LoadCountryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: BlocBuilder<CountryBloc, CountryState>(
        builder: (context, state) {
          if (state is CountryLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // if (state is CountryInitialState) {
          //   return Center(
          //     child: ElevatedButton(
          //       onPressed: () {},
          //       child: const Text('Get the Countries',
          //           style: TextStyle(fontSize: 18)),
          //     ),
          //   );
          // }

          if (state is CountryLoadedState) {
            List<MapEntry<String, List<CountryModel>>> sortedGroupedList =
                (generateCountryMap(state.groupingStatus, state.countryList)
                      ..forEach(
                        (key, value) {
                          value.sort((country1, country2) => generateSorting(
                              state.sortingStatus, country1, country2));
                        },
                      ))
                    .entries
                    .toList();

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  expandedHeight: 50,
                  pinned: true,
                  flexibleSpace: const FlexibleSpaceBar(
                    title: Text(
                      'Flutter Assignment',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                  ),
                  actions: [
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchScreen())),
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    wspacer(15),
                  ],
                ),
                const SliverToBoxAdapter(
                  child: SortGroupWidget(),
                ),
                MultiSliver(
                  children:
                      buildCountryGroups(gridGroupedList: sortedGroupedList),
                )
              ],
            );
          }
          return const Center();
        },
      ),
    );
  }
}

List<Widget> buildCountryGroups(
        {required List<MapEntry<String, List<CountryModel>>>
            gridGroupedList}) =>
    gridGroupedList
        .map((e) => GroupGridWidget(groupTitle: e.key, countryList: e.value))
        .toList();
