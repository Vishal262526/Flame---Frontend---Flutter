import 'package:flutter/material.dart';
import 'package:flame/core/common/widgets/input.dart';
import 'package:country_state_city/models/state.dart' as state;

class SelectStateSheet extends StatelessWidget {
  final Function(String value)? onChanged;
  final List<state.State> statesList;
  final Function(state.State state) onSelected;

  const SelectStateSheet({
    super.key,
    required this.onChanged,
    required this.statesList,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Input(
            placeholder: 'Search for State',
            onChanged: onChanged,
          ),
        ),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: statesList.length,
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  onSelected(statesList[index]);
                },
                title: Text(statesList[index].name),
              );
            },
          ),
        )
      ],
    );
  }
}
