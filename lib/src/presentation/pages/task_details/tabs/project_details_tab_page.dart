import 'package:flutter/material.dart';
import 'package:flutter_timer/res/app_strings.dart';
import 'package:flutter_timer/src/domain/model/project.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_text.dart';
import 'package:flutter_timer/src/presentation/widgets/space.dart';
import 'package:flutter_timer/src/utils/extensions.dart';

class ProjectDetailsTabPage extends StatefulWidget {
  const ProjectDetailsTabPage({super.key, required this.odooProject});

  final OdooProject odooProject;

  @override
  State<ProjectDetailsTabPage> createState() => _ProjectDetailsTabPageState();
}

class _ProjectDetailsTabPageState extends State<ProjectDetailsTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _projectResume(),
          const VSpace(8),
          _projectDescription(),
        ],
      ),
    );
  }

  Container _projectResume() {
    return Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _labelValue(
                label: AppStrings.of(context).project,
                value: widget.odooProject.name,
                color: HexColor.fromHex(widget.odooProject.color),
              ),
              const VSpace(16),
              _labelValue(
                label: AppStrings.of(context).deadLineLabel,
                value: widget.odooProject.deadline?.toDateString() ?? "",
              ),
              const VSpace(16),
              _labelValue(
                label: AppStrings.of(context).assignedTo,
                value: widget.odooProject.assignee,
              ),
            ],
          ),
        );
  }

  Container _projectDescription() {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OdooText(
            AppStrings.of(context).description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const VSpace(4),
          OdooText(
            widget.odooProject.description,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }

  Widget _labelValue({
    required String label,
    required String value,
    Color? color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OdooText(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const VSpace(4),
        Container(
          padding: color != null ? const EdgeInsets.only(left: 8) : null,
          decoration: BoxDecoration(
            border: color != null
                ? Border(
                    left: BorderSide(
                      width: 2,
                      color: color,
                    ),
                  )
                : null,
          ),
          child: OdooText(
            value,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        )
      ],
    );
  }
}
