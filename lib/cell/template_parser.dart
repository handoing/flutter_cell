import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

import 'attribute_parser.dart';

class TemplateParser extends StatelessWidget {
  TemplateParser({
    @required this.template,
    this.slots,
    this.events,
  });

  final String template;
  final Map slots;
  final Map events;

  static const _supportedElements = [
    "body",
    "appbar",
    "container",
    "center",
    "column",
    "padding",
    "floatingactionbutton",
    "raisedbutton",
    "text",
    "icon",
    "slot"
  ];

  @override
  Widget build(BuildContext context) {
    return parse(template);
  }

  Widget parse(String template) {
    String _template = template.replaceAll("\n", "");
    dom.Document document = parser.parse(_template);
    return _parseNode(document.body);
  }

  List<Widget> _parseMultiChildNode(List<dom.Node> nodeList) {
    return nodeList.map((node) {
      return _parseNode(node);
    }).toList();
  }


  Widget _parseSingleChildNode(List<dom.Node> nodeList) {
    dom.Element node = nodeList.firstWhere((node) {
      return node is dom.Element;
    });
    return _parseNode(node);
  }

  Widget _parseNode(dom.Node node) {
    if (node is dom.Element) {
      if (!_supportedElements.contains(node.localName)) {
        return Container();
      }

      if (node.attributes.containsKey('onclick')) {
        return GestureDetector(
          child: _parseSingleChildNode(node.nodes),
          onTap: () {
            events[node.attributes['onclick']]();
          },
        );
      }

      switch (node.localName) {
        case "body":
          return _parseSingleChildNode(node.nodes);
          break;
        case "appbar":
          return AppBar(
            title: _parseSingleChildNode(node.nodes),
          );
          break;
        case "container":
          return Container(
            child: _parseSingleChildNode(node.nodes),
          );
          break;
        case "center":
          return Center(
            child: _parseSingleChildNode(node.nodes),
          );
        case "column":
          MainAxisAlignment mainAxisAlignment = parseMainAxisAlignment(node.attributes['alignment']);
          CrossAxisAlignment crossAxisAlignment = parseCrossAxisAlignment(node.attributes['crossalignment']);
          return Column(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: _parseMultiChildNode(node.nodes),
          );
          break;
        case "padding":
          EdgeInsetsGeometry padding = parseEdgeInsetsGeometry(node.attributes['padding']);
          return Padding(
            padding: padding,
            child: _parseSingleChildNode(node.nodes),
          );
          break;
        case "floatingactionbutton":
          String tooltip = node.attributes['tooltip'];
          return FloatingActionButton(
            onPressed: () {
              if (node.attributes.containsKey('onpressed')) {
                events[node.attributes['onpressed']]();
              }
            },
            tooltip: tooltip,
            child: _parseSingleChildNode(node.nodes),
          );
          break;
        case "raisedbutton":
          return RaisedButton(
            onPressed: () {},
            child: _parseSingleChildNode(node.nodes),
          );
          break;
        case "text":
          return Text(node.text);
          break;
        case "icon":
          return Icon(parseIcon(node.attributes['type']));
          break;
        case "slot":
          return slots[node.attributes['name']];
          break;
        default:
          return Container();
          break;
      }
    } else if (node is dom.Text) {
      if (node.text.trim() != '') {
        return Text(node.text);
      }
      return Container();
    }
    return Container();
  }
}