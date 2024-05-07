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
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  itemData["name"],
                  textAlign: TextAlign.center,
                ),
                content: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                    color: Colors.grey.shade900,
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: itemData["task"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              );
            });
      },
      child: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  itemData["name"],
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
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
      ),
    );
  }
}
