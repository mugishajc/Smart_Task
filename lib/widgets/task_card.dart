import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_task/feature/home/controllers/tasks_controller.dart';
import 'package:smart_task/feature/task_details/controllers/task_details_controller.dart';
import 'package:smart_task/feature/task_details/views/details_screen.dart';
import 'package:smart_task/utils/navigation.dart';
import 'package:smart_task/utils/utils.dart';

class TaskCard extends ConsumerWidget {
  TaskCard({
    this.animation,
    this.backgroundColor = InkomokoSmartTaskColors.white,
    this.borderOutline = true,
  });

  final Animation<double>? animation;
  final Color backgroundColor;
  final bool borderOutline;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskProvider);

    return GestureDetector(
      onTap: () {
        if (!task.isCompleted) {
          ref.watch(taskDetailsProvider.state).state = task;
          DetailsScreen().push(context);
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: InkomokoSmartTaskSize.height(context, 19)), // Pass context
        child: Dismissible(
          key: UniqueKey(),
          background: Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: Icon(Icons.delete),
            color: InkomokoSmartTaskColors.lightRed,
          ),
          onDismissed: (direction) async {
            ref.read(tasksProvider).removeTodo(task.uid);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: InkomokoSmartTaskSize.height(context, 15)), // Pass context
            decoration: BoxDecoration(
              color: backgroundColor,
              border: borderOutline
                  ? Border.all(color: InkomokoSmartTaskColors.charcoal)
                  : null,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(left: InkomokoSmartTaskSize.width(context, 22)), // Pass context
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: InkomokoSmartTaskSize.width(context, 22)), // Pass context
                                    child: Icon(
                                      Icons.brightness_1_sharp,
                                      color: task.priority == "Low"
                                          ? Colors.green
                                          : task.priority == "Medium"
                                          ? Colors.orange
                                          : Colors.red,
                                      size: InkomokoSmartTaskSize.width(context, 16), // Pass context
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      task.title,
                                      style:
                                      InkomokoSmartTaskTextStyle.bodyText2(context).copyWith( // Pass context
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (task.description.length > 0)
                                Column(
                                  children: [
                                    SizedBox(height: InkomokoSmartTaskSize.height(context, 5)), // Pass context
                                    Text(
                                      task.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: InkomokoSmartTaskTextStyle.bodyText3(context), // Pass context
                                    ),
                                    SizedBox(height: InkomokoSmartTaskSize.height(context, 10)), // Pass context
                                  ],
                                ),
                              Text(
                                task.dateTime,
                                style: InkomokoSmartTaskTextStyle.bodyText2(context).copyWith( // Pass context
                                  color: InkomokoSmartTaskColors.charcoal.withOpacity(0.70),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (!task.isCompleted)
                      ref.read(tasksProvider).completeTask(task.uid);
                    else
                      ref.read(tasksProvider).undoCompleteTask(task.uid);
                  },
                  child: Container(
                    margin: EdgeInsets.all(InkomokoSmartTaskSize.width(context, 36)), // Pass context
                    child: Icon(
                      task.isCompleted
                          ? Icons.brightness_1
                          : Icons.brightness_1_outlined,
                      color: InkomokoSmartTaskColors.primary,
                      size: InkomokoSmartTaskSize.width(context, 24), // Pass context
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}