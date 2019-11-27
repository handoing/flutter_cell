import 'package:flutter/material.dart';
import 'template_parser.dart';

class Cell extends StatelessWidget {

  Cell({
    Key key,
    @required this.template,
    this.slots,
    this.events,
  }) : super(key: key);

  final String template;
  final Map slots;
  final Map events;

  @override
  Widget build(BuildContext context) {
    return TemplateParser(
        template: template,
        slots: slots,
        events: events
    );
  }
}