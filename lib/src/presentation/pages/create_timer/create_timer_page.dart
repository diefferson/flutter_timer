import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/res/app_strings.dart';
import 'package:flutter_timer/src/bloc/create_timer_states.dart';
import 'package:flutter_timer/src/domain/model/project.dart';
import 'package:flutter_timer/src/domain/model/task.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_app_bar.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_background.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_button.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_dropdown.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_form_field.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_text.dart';
import 'package:flutter_timer/src/presentation/widgets/space.dart';
import 'package:flutter_timer/src/utils/base_bloc.dart';

import 'create_timer_bloc.dart';
import 'create_timer_page_actions.dart';

class CreateTimerPage extends StatefulWidget {
  const CreateTimerPage({super.key});

  static Future<bool?> push({required BuildContext context}) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (c) => const CreateTimerPage(),
      ),
    );
  }

  @override
  State<CreateTimerPage> createState() => _CreateTimerPageState();
}

class _CreateTimerPageState extends BaseState<CreateTimerPage, CreateTimerBloc>
    with CreateTimerPageActions {
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _descriptionController =
        TextEditingController(text: bloc.state.description);
  }

  @override
  Widget build(BuildContext context) {
    return OdooBackground(
      child: Scaffold(
        appBar: OdooAppBar(
          title: AppStrings.of(context).createTimer,
        ),
        body: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<CreateTimerBloc, CreateTimerState>(
              bloc: bloc,
              builder: (context, state) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          OdooDropdown<OdooProject>(
                            hint: AppStrings.of(context).project,
                            selectedValue: state.selectedProject,
                            items: state.projects,
                            onChanged: bloc.selectProject,
                          ),
                          const VSpace(28),
                          OdooDropdown<OdooTask>(
                            selectedValue: state.selectedTask,
                            hint: AppStrings.of(context).task,
                            items: state.tasks,
                            onChanged: bloc.selectTask,
                          ),
                          const VSpace(28),
                          OdooFormField(
                            hint: AppStrings.of(context).description,
                            validator: (s) {
                              if (s == null || s.isEmpty) {
                                return AppStrings.of(context).requiredField;
                              }
                              return null;
                            },
                            controller: _descriptionController,
                            onFieldSubmitted: bloc.setDescription,
                          ),
                          const VSpace(8),
                          GestureDetector(
                            onTap: bloc.favoriteToggle,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: state.favorite,
                                  onChanged: (v) => bloc.favoriteToggle(),
                                ),
                                OdooText(
                                  AppStrings.of(context).makeFavorite,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SafeArea(
                      top: false,
                      child: OdooButton(
                        label: AppStrings.of(context).createTimer,
                        onPressed: submitForm,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
