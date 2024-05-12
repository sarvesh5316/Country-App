import 'package:country_app/presentation/widgets/groupwidgets/const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/country_model.dart';

class CountryWidget extends StatelessWidget {
  CountryWidget({required this.countryModel, Key? key}) : super(key: key);

  final CountryModel countryModel;

  final NumberFormat populationFormat =
      NumberFormat('###,###,###,###', 'en_US');
  final NumberFormat areaFormat = NumberFormat('###,###,###,###.#', 'en_US');

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.white,
      elevation: 1,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Country Description",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Times New Roman',
                fontWeight: FontWeight.w700,
              ),
            ),
            const Divider(color: Colors.black),
            hspacer(20),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(countryModel.flagPng),
                ),
                wspacer(10),
                Expanded(
                  child: Text(countryModel.nameCommon,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Times New Roman',
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
            const Divider(color: Colors.grey),
            Row(
              children: [
                titleGenerator('Official Name: '),
                wspacer(10),
                Expanded(
                  child: Text(
                    countryModel.nameOfficial,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.grey),
            rowGenerator(
              firstHeader: 'Capital',
              firstText: countryModel.capital,
              secondHeader: 'Continent',
              secondText: countryModel.continents,
            ),
            const Divider(color: Colors.grey),
            rowGenerator(
              firstHeader: 'Population',
              firstText: populationFormat.format(countryModel.population),
              secondHeader: 'Region',
              secondText: countryModel.region,
            ),
            const Divider(color: Colors.grey),
            rowGenerator(
              firstHeader: 'Area',
              firstText: '${areaFormat.format(countryModel.area)} km²',
              secondHeader: 'Subregion',
              secondText: countryModel.subregion,
            )
          ],
        ),
      ),
    );
  }
}

Row rowGenerator({
  required String firstHeader,
  required String firstText,
  required String secondHeader,
  required String secondText,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleGenerator(firstHeader),
          Text(firstText,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Times New Roman',
              )),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          titleGenerator(secondHeader),
          Text(secondText,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Times New Roman',
              )),
        ],
      ),
    ],
  );
}

Text titleGenerator(String title) => Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontFamily: 'Times New Roman',
        fontWeight: FontWeight.bold,
      ),
    );
