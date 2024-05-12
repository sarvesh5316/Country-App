import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_app/presentation/widgets/country_widget.dart';
import 'package:country_app/presentation/widgets/groupWidgets/group_background_widget.dart';
import 'package:country_app/presentation/widgets/groupWidgets/group_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../data/models/country_model.dart';

class GroupGridWidget extends StatelessWidget {
  const GroupGridWidget(
      {required this.groupTitle, required this.countryList, Key? key})
      : super(key: key);

  final String groupTitle;
  final List<CountryModel> countryList;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(8).copyWith(top: 0),
      sliver: MultiSliver(
        pushPinnedChildren: true,
        children: [
          SliverStack(
            insetOnOverlap: true,
            children: [
              const SliverPositioned.fill(
                top: GroupHeaderWidget.padding,
                child: GroupBackgroundWidget(),
              ),
              MultiSliver(
                children: [
                  SliverPinnedHeader(
                      child: GroupHeaderWidget(title: groupTitle)),
                  SliverClip(
                    child: buildGrid(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildGrid() => SliverGrid(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        delegate: SliverChildBuilderDelegate((context, index) {
          return InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl: countryList[index].flagPng,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  // SizedBox(
                  //   height: 50,
                  //   child: Image.network(countryList[index].flagPng),
                  // ),
                  SizedBox(
                    height: 20,
                    child: Text(
                      countryList[index].nameCommon,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                  )
                ],
              ),
            ),
            onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) =>
                    CountryWidget(countryModel: countryList[index])),
          );
        }, childCount: countryList.length),
      );
}
