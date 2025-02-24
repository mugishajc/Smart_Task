import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_task/data/model/todo.dart';
import 'package:smart_task/utils/utils.dart';
import 'package:smart_task/widgets/dropdown_menu.dart';
import 'package:smart_task/widgets/k_textfield.dart';
import 'package:smart_task/utils/debouncer.dart';

import '../controllers/task_details_controller.dart';

class TaskDetailsCard extends ConsumerStatefulWidget {
  @override
  ConsumerState<TaskDetailsCard> createState() => _TaskCardState();
}

class _TaskCardState extends ConsumerState<TaskDetailsCard> {
  final _debouncer = Debouncer(milliseconds: 500);

  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDetailsController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Todo _todo = ref.read(taskDetailsProvider);
    taskTitleController.text = _todo.title;
    taskDetailsController.text = _todo.description;
    dateTimeController.text = _todo.dateTime;
    priorityController.text = _todo.priority;
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoState = ref.watch(taskDetailsProvider.state);
    return Container(
      margin: EdgeInsets.only(bottom: InkomokoSmartTaskSize.height(context, 19)),
      padding: EdgeInsets.symmetric(vertical: InkomokoSmartTaskSize.height(context, 15)),
      decoration: BoxDecoration(
        color: InkomokoSmartTaskColors.accent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: InkomokoSmartTaskSize.width(context, 22)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: InkomokoSmartTaskSize.width(context, 22)),
                  child: Icon(
                    Icons.brightness_1_sharp,
                    color: todoState.state.priority == "Low"
                        ? Colors.green
                        : todoState.state.priority == "Medium"
                        ? Colors.orange
                        : Colors.red,
                    size: InkomokoSmartTaskSize.width(context, 16),
                  ),
                ),
                Flexible(
                  child: KTextField(
                    controller: taskTitleController,
                    textStyle: InkomokoSmartTaskTextStyle.bodyText2(context)
                        .copyWith(fontWeight: FontWeight.w600),
                    onChanged: (v) {
                      todoState.update((state) => state.copyWith(title: v));
                      _debouncer.run(() => ref
                          .read(taskDetailsViewControllerProvider)
                          .updateTask(todoState.state.uid, title: v));
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: InkomokoSmartTaskSize.height(context, 5)),
            KTextField(
              controller: taskDetailsController,
              textStyle: InkomokoSmartTaskTextStyle.bodyText3(context),
              hintText: "Details",
              onChanged: (v) => _debouncer.run(() {
                todoState.update((state) => state.copyWith(description: v));
                _debouncer.run(() => ref
                    .read(taskDetailsViewControllerProvider)
                    .updateTask(todoState.state.uid, description: v));
              }),
            ),
            SizedBox(height: InkomokoSmartTaskSize.height(context, 10)),
            KTextField(
              controller: dateTimeController,
              textStyle: InkomokoSmartTaskTextStyle.bodyText2(context).copyWith(
                color: InkomokoSmartTaskColors.charcoal.withOpacity(0.70),
              ),
              isDateTime: true,
              onChanged: (v) {
                todoState.update((state) => state.copyWith(dateTime: v));
                _debouncer.run(() => ref
                    .read(taskDetailsViewControllerProvider)
                    .updateTask(todoState.state.uid, dateTime: v));
              },
            ),
            SizedBox(height: InkomokoSmartTaskSize.height(context, 10)),
            Row(
              children: [
                Text(
                  "Priority:",
                  style: InkomokoSmartTaskTextStyle.bodyText2(context),
                ),
                Flexible(
                  child: DropdownMenus(
                    controller: priorityController,
                    items: ['Low', 'Medium', 'High'],
                    showTrailing: false,
                    menuBackgroundColor: InkomokoSmartTaskColors.transparent,
                    itemBackgroundColor: InkomokoSmartTaskColors.accent,
                    padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                    hintTextStyle: InkomokoSmartTaskTextStyle.bodyText2(context),
                    onChange: () {
                      todoState.update((state) =>
                          state.copyWith(priority: priorityController.text));
                      _debouncer.run(() => ref
                          .read(taskDetailsViewControllerProvider)
                          .updateTask(todoState.state.uid,
                          priority: priorityController.text));
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}