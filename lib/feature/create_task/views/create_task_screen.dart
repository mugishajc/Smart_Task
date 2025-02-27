import 'package:flutter/material.dart';
import 'package:smart_task/feature/create_task/controllers/create_task_controller.dart';
import 'package:smart_task/utils/navigation.dart';
import 'package:smart_task/core/base/base_view.dart';
import 'package:smart_task/utils/utils.dart';
import 'package:smart_task/widgets/k_app_bar.dart';
import 'package:smart_task/widgets/k_button.dart';
import 'package:smart_task/widgets/k_dropdown_field.dart';
import 'package:smart_task/widgets/k_textfield.dart';
import 'package:nb_utils/nb_utils.dart';

class CreateTaskScreen extends BaseView {
  const CreateTaskScreen({super.key});

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends BaseViewState<CreateTaskScreen> {
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDetailsController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController priorityController =
  TextEditingController(text: 'Low');

  @override
  void initState() {
    super.initState();
    priorityController.addListener(_onPriorityChanged);
  }

  @override
  void dispose() {
    priorityController.removeListener(_onPriorityChanged);
    super.dispose();
  }

  void _onPriorityChanged() {
    print('Priority changed to: ${priorityController.text}');
  }

  @override
  PreferredSizeWidget appBar() {
    return KAppBar(
      titleText: 'New Task',
      onTap: () => const Placeholder().pop(context),
      context: context,
    );
  }

  @override
  Widget body() {
    return Column(
      children: [
        SizedBox(height: InkomokoSmartTaskSize.height(context, 40)),
        KTextFormField(
          hintText: "Task Name",
          controller: taskTitleController,
          multiline: true,
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context, 22)),
        KTextFormField(
          hintText: "Details",
          controller: taskDetailsController,
          multiline: true,
          minimumLines: 5,
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context, 22)),
        KTextFormField(
          hintText: "Date Time",
          controller: dateTimeController,
          isCalenderField: true,
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context, 22)),
        KDropdownField(
          controller: priorityController,
          dropdownFieldOptions: ['Low', 'Medium', 'High'],
        ), // Removed context
        SizedBox(height: InkomokoSmartTaskSize.height(context, 90)),
        KFilledButton(
            buttonText: "Add Task",
            onPressed: () async {
              if (taskTitleController.text.trim().isNotEmpty) {
                await ref.read(createTaskProvider).createNewTask(
                  taskTitleController.text,
                  taskDetailsController.text,
                  dateTimeController.text,
                  priorityController.text,
                );
                const Placeholder().pop(context);
              } else {
                snackBar(context,
                    title: 'Please enter a task name',
                    backgroundColor: InkomokoSmartTaskColors.charcoal);
              }
            })
      ],
    );
  }
}