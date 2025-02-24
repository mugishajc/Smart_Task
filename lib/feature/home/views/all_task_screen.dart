import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_task/utils/navigation.dart';
import 'package:smart_task/core/base/base_view.dart';
import 'package:smart_task/utils/utils.dart';
import 'package:smart_task/widgets/k_app_bar.dart';
import 'package:smart_task/widgets/k_button.dart';
import 'package:smart_task/widgets/task_card.dart';
import 'package:smart_task/core/logger.dart';

import '../../create_task/views/create_task_screen.dart';
import '../controllers/tasks_controller.dart';

class AllTasksScreen extends BaseView {
  @override
  BaseViewState<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends BaseViewState<AllTasksScreen> {
  @override
  PreferredSizeWidget appBar() {
    return KAppBar(
      titleText: "All Tasks",
      onTap: () => const Placeholder().pop(context),
      context: context,
    );
  }

  @override
  bool scrollable() => false;

  @override
  Widget body() {
    final pendingTasksStream = ref.watch(pendingTasksProvider);

    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: InkomokoSmartTaskSize.height(context, 20)),
          Expanded(
            child: pendingTasksStream.when(
                loading: () => Container(),
                error: (e, stackTrace) {
                  Log.error('Error loading pending tasks: ${e.runtimeType}: $e');
                  Log.error(stackTrace.toString());
                  return ErrorWidget(e);
                },
                data: (snapshot) {
                  if (snapshot == null) {
                    return Center(child: Text("No tasks found."));
                  }
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.length,
                      itemBuilder: (context, index) {
                        return ProviderScope(
                          overrides: [
                            taskProvider.overrideWithValue(snapshot[index]),
                          ],
                          child: TaskCard(
                            backgroundColor: InkomokoSmartTaskColors.accent,
                            borderOutline: false,
                          ),
                        );
                      });
                }),
          ),
          SizedBox(height: InkomokoSmartTaskSize.height(context, 20)),
          Padding(
            padding: EdgeInsets.only(
                bottom: Platform.isAndroid ? InkomokoSmartTaskSize.height(context, 50) : 0),
            child: KFilledButton.iconText(
                icon: Icons.add,
                buttonText: 'Create New Task',
                onPressed: () {
                  CreateTaskScreen().push(context);
                }),
          ),
        ],
      ),
    );
  }
}