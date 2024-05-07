import 'package:crud_test/model/sql.dart';
import 'package:crud_test/widgets/list_item.dart';
import 'package:crud_test/widgets/task_dialog.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  List<Map<String, dynamic>> _data = [];

  Future<void> addItem(String name, String? task) async {
    await SQLHelper.createItem(name, task);
    refreshData();
  }

  Future<void> deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    refreshData();
  }

  Future<void> editItem(int id, String name, String? task) async {
    await SQLHelper.updateItem(id, name, task);
    refreshData();
  }

  void refreshData() async {
    final items = await SQLHelper.getItems();
    setState(() {
      _data = items;
    });
  }

  void clearAll() async {
    final items = await SQLHelper.getItems();
    for (var item in items) {
      SQLHelper.deleteItem(item["id"]);
    }
    refreshData();
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Todo",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w500,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        shape: const LinearBorder(
          side: BorderSide(
            width: 2,
            color: Colors.white,
          ),
          bottom: LinearBorderEdge(
            size: 0.5,
          ),
        ),
        actions: [
          _data.isNotEmpty
              ? TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            "Clear Data",
                            style: TextStyle(
                              color: Colors.grey.shade900,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: Colors.white,
                          surfaceTintColor: Colors.white,
                          content: Text(
                            "Are you want to clear all data?",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.grey.shade900,
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                clearAll();
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade900,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text(
                                "Clear",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    "Clear",
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                )
              : const SizedBox(),
          _data.isNotEmpty
              ? const SizedBox(
                  width: 10,
                )
              : const SizedBox(),
        ],
      ),
      backgroundColor: Colors.grey.shade900,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 20,
          ),
          _data.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: _data.length,
                    itemBuilder: (context, index) {
                      return CustomListItem(
                        id: _data[index]["id"],
                        itemData: _data[index],
                        delete: deleteItem,
                        edit: editItem,
                      );
                    },
                  ),
                )
              : Center(
                  child: Image.asset(
                    "lib/assets/back.png",
                    fit: BoxFit.cover,
                    width: 500,
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        hoverElevation: 1,
        onPressed: () async => {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return PopUpMenu(
                id: null,
                create: addItem,
              );
            },
          ),
        },
        backgroundColor: Colors.white,
        splashColor: Colors.grey.shade600,
        hoverColor: Colors.grey.shade500,
        label: Text(
          "Add",
          style: TextStyle(
            color: Colors.grey.shade900,
          ),
        ),
        extendedPadding: const EdgeInsets.symmetric(horizontal: 60),
      ),
    );
  }
}
