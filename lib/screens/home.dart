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
  List<Map<String, dynamic>> _data = [
    {"id": 1, "name": "loay", "task": "task"}
  ];

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

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      backgroundColor: Colors.grey.shade900,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
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
        label: Text(
          "Add",
          style: TextStyle(
            color: Colors.grey.shade900,
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
