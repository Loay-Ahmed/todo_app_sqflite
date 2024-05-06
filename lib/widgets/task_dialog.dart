import 'package:flutter/material.dart';

class PopUpMenu extends StatefulWidget {
  const PopUpMenu({
    super.key,
    this.id,
    this.name,
    this.task,
    this.create,
    this.update,
  });

  final int? id;
  final String? name;
  final String? task;
  final Future<void> Function(int, String, String?)? update;
  final Future<void> Function(String, String?)? create;

  @override
  State<PopUpMenu> createState() => _PopUpMenuState();
}

class _PopUpMenuState extends State<PopUpMenu> {
  final TextEditingController controller1 = TextEditingController();

  final TextEditingController controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    controller1.text = widget.id == null ? "" : widget.name!;
    controller2.text = widget.id == null ? "" : widget.task!;
    return AlertDialog(
      title: Text(
        widget.id == null ? "Create Task" : "Edit Task",
        style: TextStyle(
          color: Colors.grey.shade900,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: controller1,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade900,
            ),
            cursorColor: Colors.grey.shade900,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade900,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              label: Text(
                "Name",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade900,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade500),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: controller2,
            style: TextStyle(
              color: Colors.grey.shade900,
              fontWeight: FontWeight.w500,
            ),
            cursorColor: Colors.grey.shade900,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade900,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              label: Text(
                "Task",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade900,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade500),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
        ],
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
            if (widget.id == null) {
              widget.create!(controller1.text, controller2.text);
            } else {
              widget.update!(widget.id!, controller1.text, controller2.text);
            }
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade900,
            foregroundColor: Colors.white,
          ),
          child: Text(
            widget.id == null ? 'Create' : "Update",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }
}
