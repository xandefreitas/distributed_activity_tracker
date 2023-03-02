import 'package:distributed_activity_tracker/common/enums/activity_type_enum.dart';
import 'package:flutter/material.dart';

import 'components/activity_add_button.dart';
import 'components/activity_list_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool isEndOfTheList = false;
  String filterSelected = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activities'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange[300],
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 64),
          child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            trackVisibility: true,
            interactive: true,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...ActivityType.values
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0, left: 8, right: 8),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                filterSelected = e.value;
                              });
                            },
                            child: Tooltip(
                              message: e.value,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  e.icon,
                                  color: e.color.withOpacity(filterSelected == e.value ? 1.0 : 0.4),
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ActivityListBody(
        filterSelected: filterSelected,
        showActionButton: (value) {
          setState(() {
            isEndOfTheList = value;
          });
        },
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ActivityAddButton(isEndOfTheList: isEndOfTheList),
    );
  }
}
