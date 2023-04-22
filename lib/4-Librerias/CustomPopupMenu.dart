import 'package:flutter/material.dart';

class PopupMenuWidget<T> extends PopupMenuEntry<T> {
  const PopupMenuWidget({
    Key? key,
    required this.height,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  final double height;

  bool get enabled => false;

  @override
  _PopupMenuWidgetState createState() => _PopupMenuWidgetState();

  @override
  bool represents(T? value) {
    return false;
  }
}

class _PopupMenuWidgetState extends State<PopupMenuWidget> {
  @override
  Widget build(BuildContext context) => widget.child;
}

class CustomPopUpMenu extends StatefulWidget {
  const CustomPopUpMenu({super.key});

  @override
  State<CustomPopUpMenu> createState() => _CustomPopUpMenuState();
}

enum SampleItem { itemOne, itemTwo, itemThree }

class _CustomPopUpMenuState extends State<CustomPopUpMenu> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(50.0),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          const SizedBox(width: 10.0),
          selectedMenu == SampleItem.itemOne
              ? const Icon(Icons.done)
              : selectedMenu == SampleItem.itemTwo
                  ? const Icon(Icons.close)
                  : selectedMenu == SampleItem.itemThree
                      ? const Text('F/S')
                      : const SizedBox(
                          width: 24,
                        ),
          PopupMenuButton<SampleItem>(
            icon: const Icon(Icons.arrow_drop_down_rounded),
            initialValue: selectedMenu,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            padding: EdgeInsets.zero,
            offset: const Offset(-106, -80),
            onSelected: (SampleItem item) {
              setState(
                () {
                  selectedMenu = item;
                },
              );
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuWidget(
                  height: 30.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        icon: const Icon(Icons.done),
                        onPressed: () {
                          setState(() {
                            selectedMenu = SampleItem.itemOne;
                          });
                        },
                      ),
                      IconButton(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            selectedMenu = SampleItem.itemTwo;
                          });
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            selectedMenu = SampleItem.itemThree;
                          });
                        },
                        child: Text(
                          'F/S',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      // IconButton(
                      //   style: ButtonStyle(
                      //     shape: MaterialStateProperty.all(
                      //         BeveledRectangleBorder()),
                      //   ),
                      //   padding: const EdgeInsets.symmetric(horizontal: 22),
                      //   icon: const Icon(Icons.construction),
                      //   onPressed: () {
                      //     setState(() {
                      //       selectedMenu = SampleItem.itemThree;
                      //     });
                      //   },
                      // ),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}
