import 'package:crud_test/widgets/task_dialog.dart';
import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    super.key,
    required this.id,
    required this.itemData,
    required this.edit,
    required this.delete,
  });

  final int id;
  final Map<String, dynamic> itemData;
  final Future<void> Function(int id, String name, String? task) edit;
  final Future<void> Function(int id) delete;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        border: Border.all(
          color: Colors.transparent,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemData["name"],
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                itemData["task"],
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () async => {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return PopUpMenu(
                        id: itemData["id"],
                        name: itemData["name"],
                        task: itemData["task"],
                        update: edit,
                      );
                    },
                  ),
                },
                icon: const Icon(Icons.edit),
              ),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                onPressed: () async {
                  await delete(id);
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
