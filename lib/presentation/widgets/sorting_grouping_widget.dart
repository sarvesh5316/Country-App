import 'package:country_app/presentation/widgets/groupwidgets/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/constants/constants.dart';
import '../../logic/bloc/countrybloc/country_bloc.dart';
import '../../logic/cubit/sortgroupcubit/sort_group_cubit.dart';

class SortGroupWidget extends StatelessWidget {
  const SortGroupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SortGroupCubit, SortGroupState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(top: 10),
          color: Theme.of(context).primaryColor.withOpacity(0.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildDropDownButton('sort', context, state),
              buildDropDownButton('group', context, state),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<CountryBloc>(context).add(
                    ChangeGroupAndSortEvent(
                      sortValue: state.sortValue,
                      groupValue: state.groupValue,
                    ),
                  );
                },
                child: const Text('Apply'),
              ),
            ],
          ),
        );
      },
    );
  }

  buildDropDownButton(String type, BuildContext context, SortGroupState state) {
    switch (type) {
      case 'sort':
        return Column(
          children: [
            Row(
              children: [
                const Text('Sorted By', style: TextStyle(fontSize: 16)),
                wspacer(5),
                const Icon(Icons.sort)
              ],
            ),
            DropdownButton<String>(
              value: state.sortValue,
              items: sortItems.map(buildMenuItem).toList(),
              onChanged: (value) {
                BlocProvider.of<SortGroupCubit>(context)
                    .onChangeSortOption(value!);
              },
            ),
          ],
        );
      case 'group':
        return Column(
          children: [
            Row(
              children: [
                const Text('Grouped By', style: TextStyle(fontSize: 16)),
                wspacer(5),
                const Icon(Icons.sort)
              ],
            ),
            DropdownButton<String>(
              value: state.groupValue,
              items: groupItems.map(buildMenuItem).toList(),
              onChanged: (value) {
                BlocProvider.of<SortGroupCubit>(context)
                    .onChangeGroupOption(value!);
              },
            ),
          ],
        );
    }
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(item),
    );
  }
}
