import 'package:flutter/material.dart';
import 'package:smart_task/feature/task_details/controllers/task_details_controller.dart';
import 'package:smart_task/feature/task_details/widgets/sub_task_card.dart';
import 'package:smart_task/core/base/base_view.dart';
import 'package:smart_task/utils/utils.dart';
import 'package:smart_task/widgets/k_app_bar.dart';
import 'package:smart_task/widgets/k_button.dart';

import '../widgets/task_details_card.dart';

class DetailsScreen extends BaseView {
  @override
  BaseViewState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends BaseViewState<DetailsScreen> {
  @override
  PreferredSizeWidget appBar() {
    return KAppBar(
      titleText: "Task Details",
      onTap: () => Navigator.pop(context),
      context: context,
    );
  }

  @override
  Widget body() {
    final todoState = ref.watch(taskDetailsProvider);
    final controller = ref.watch(taskDetailsViewControllerProvider);

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: InkomokoSmartTaskSize.height(context, 40)),
        TaskDetailsCard(),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: todoState.subTask.length,
          itemBuilder: (context, index) {
            return SubTaskCard(key: UniqueKey(), index: index);
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: KTextButton.iconText(
            buttonText: 'Add Task',
            assetIcon: InkomokoSmartTaskAssets.add,
            onPressed: () => controller.addSubTask(),
          ),
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context, 90)),
        KFilledButton(
          buttonText: "Complete Task",
          onPressed: () {
            controller.completeTask(todoState.uid);
            Navigator.pop(context); // Correct navigation
          },
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context, 22)),
        KOutlinedButton(
          buttonText: "Delete Task",
          textStyle: InkomokoSmartTaskTextStyle.buttonText(context, fontWeight: FontWeight.w500)
              .copyWith(color: InkomokoSmartTaskColors.red.withOpacity(0.8)),
          borderColor: InkomokoSmartTaskColors.red.withOpacity(0.8),
          onPressed: () {
            controller.removeTodo(todoState.uid);
            Navigator.pop(context); // Correct navigation
          },
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context, 90)),
      ],
    );
  }
}