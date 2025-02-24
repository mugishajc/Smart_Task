import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_task/core/logger.dart';
import 'package:smart_task/data/model/todo.dart';
import 'package:smart_task/utils/navigation.dart';
import 'package:smart_task/core/base/base_view.dart';
import 'package:smart_task/feature/home/views/all_task_screen.dart';
import 'package:smart_task/feature/authentication/views/login_screen.dart';
import 'package:smart_task/utils/utils.dart';
import 'package:smart_task/widgets/k_expansion_tile.dart';
import 'package:smart_task/widgets/k_button.dart';
import 'package:smart_task/widgets/task_card.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../authentication/controllers/authentication_controller.dart';
import '../../create_task/views/create_task_screen.dart';
import '../controllers/tasks_controller.dart';

class HomeScreen extends BaseView {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseViewState<HomeScreen> {
  @override
  PreferredSizeWidget appBar() {
    return _AppBarBuilder();
  }

  @override
  Widget body() {
    final pendingTasksStream = ref.watch(pendingTasksProvider);
    final completedTasksStream = ref.watch(completedTasksProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: InkomokoSmartTaskSize.height(context, 35)),
        KFilledButton.iconText(
          icon: Icons.add,
          buttonText: 'Create New Task',
          onPressed: () {
            CreateTaskScreen().push(context);
          },
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context, 72)),
        pendingTasksStream.when(
            loading: () => CircularProgressIndicator.adaptive(),
            error: (e, stackTrace) {
              Log.error('Error loading pending tasks: ${e.runtimeType}: $e');
              Log.error(stackTrace.toString());
              return ErrorWidget(e);
            },
            data: (snapshot) {
              return _PendingTasksBuilder(snapshot: snapshot);
            }),
        completedTasksStream.when(
            loading: () => Container(),
            error: (e, stackTrace) => ErrorWidget(e),
            data: (snapshot) {
              return _CompletedTasksBuilder(snapshot: snapshot);
            }),
      ],
    );
  }
}

class _AppBarBuilder extends StatelessWidget implements PreferredSizeWidget {
  _AppBarBuilder({
    Key? key,
  }) : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 0,
      titleSpacing: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                snackBar(context,
                    title: "Feature is not available yet",
                    backgroundColor: InkomokoSmartTaskColors.charcoal);
              },
              child: Image.asset(
                InkomokoSmartTaskAssets.menu,
                height: InkomokoSmartTaskSize.height(context, 32),
                width: InkomokoSmartTaskSize.width(context, 32),
              ),
            ),
            Text("My Day", style: InkomokoSmartTaskTextStyle.headLine4(context)),
            Consumer(builder: (context, ref, _) {
              return GestureDetector(
                onTap: () {
                  ref.read(authenticationProvider.notifier).signOut();
                  LoginScreen().pushAndRemoveUntil(context);
                },
                child: Image.asset(
                  InkomokoSmartTaskAssets.logout,
                  height: InkomokoSmartTaskSize.height(context, 32),
                  width: InkomokoSmartTaskSize.width(context, 32),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _PendingTasksBuilder extends StatelessWidget {
  const _PendingTasksBuilder({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  final List<Todo> snapshot;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: snapshot.isNotEmpty,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "In Progress",
                style: InkomokoSmartTaskTextStyle.bodyText2(context).copyWith(
                  color: InkomokoSmartTaskColors.charcoal.withOpacity(.71),
                ),
              ),
              Visibility(
                visible: snapshot.length > 4,
                child: GestureDetector(
                  onTap: () {
                    AllTasksScreen().push(context);
                  },
                  child: Text(
                    "View All",
                    style: InkomokoSmartTaskTextStyle.bodyText2(context).copyWith(
                      color: InkomokoSmartTaskColors.charcoal.withOpacity(.71),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: InkomokoSmartTaskSize.height(context, 20)),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.length,
              itemBuilder: (context, index) {
                return ProviderScope(
                  overrides: [taskProvider.overrideWithValue(snapshot[index])],
                  child: TaskCard(),
                );
              }),
        ],
      ),
    );
  }
}

class _CompletedTasksBuilder extends StatelessWidget {
  const _CompletedTasksBuilder({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  final List<Todo> snapshot;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: snapshot.isNotEmpty,
      child: KExpansionTile(
        title: Text(
          "Done",
          style: InkomokoSmartTaskTextStyle.bodyText2(context).copyWith(
            color: InkomokoSmartTaskColors.charcoal.withOpacity(.71),
          ),
        ),
        trailing: Image.asset(
          InkomokoSmartTaskAssets.dropdown,
          height: InkomokoSmartTaskSize.height(context, 20),
          width: InkomokoSmartTaskSize.width(context, 20),
        ),
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: snapshot.length,
              itemBuilder: (context, index) {
                return ProviderScope(
                  overrides: [taskProvider.overrideWithValue(snapshot[index])],
                  child: TaskCard(
                    borderOutline: false,
                    backgroundColor: InkomokoSmartTaskColors.lightCharcoal,
                  ),
                );
              }),
        ],
      ),
    );
  }
}