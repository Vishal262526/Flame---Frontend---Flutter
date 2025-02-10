import 'package:flutter/material.dart';
import 'package:flame/core/common/widgets/input.dart';
import 'package:country_state_city/models/city.dart' as city;

class SelectCitySheet extends StatelessWidget {
  final Function(String value)? onChanged;
  final List<city.City> cityList;
  final Function(city.City city) onSelected;

  const SelectCitySheet({
    super.key,
    required this.onChanged,
    required this.cityList,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Input(
            placeholder: 'Search for City',
            onChanged: onChanged,
          ),
        ),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: cityList.length,
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  onSelected(cityList[index]);
                },
                title: Text(cityList[index].name),
              );
            },
          ),
        )
      ],
    );
  }
}
