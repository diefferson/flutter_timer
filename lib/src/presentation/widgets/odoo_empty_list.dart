import 'package:flutter/material.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_button.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_card_image.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_text.dart';
import 'package:flutter_timer/src/presentation/widgets/space.dart';


class OdooEmptyListData {
  final String image;
  final String title;
  final String description;
  final String actionLabel;
  final VoidCallback action;

  OdooEmptyListData({required this.image, required this.title, required this.description, required this.actionLabel, required this.action});
}


class OdooEmptyList extends StatelessWidget {
  const OdooEmptyList({
    super.key,
    required this.data,
  });

  final OdooEmptyListData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OdooCardImage(
                  image: data.image,
                ),
                const VSpace(32),
                OdooText(
                  data.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const VSpace(8),
                OdooText(
                  data.description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: OdooButton(
                  onPressed: data.action,
                  label: data.actionLabel,
                ),
              ),
            ],
          ),
          const VSpace(16),
        ],
      ),
    );
  }
}
