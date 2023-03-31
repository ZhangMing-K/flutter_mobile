import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:iris_common/iris_common.dart';

class Bio extends StatefulWidget {
  const Bio({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<Bio> createState() => _BioState();
}

class _BioState extends State<Bio> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.user.description == null) {
      return Container();
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },

      ///TODO refactor and build our own ui widgets to use here. remove the package `expandable_text`, and make links clickable again.
      child: ExpandableText(
        widget.user.description ?? '',
        expandText: '',
        animation: true,
        collapseText: '',
        maxLines: 3,
        style: const TextStyle(height: 1.5),
        expandOnTextTap: true,
        collapseOnTextTap: true,
        animationDuration: const Duration(milliseconds: 500),

        ///TODO see the above todo relating to making links clickable again
        // child: Linkify(
        //     onOpen: (link) async {
        //       UrlUtils.open(link.url);
        //     },
        //     text: widget.user$.value.description ?? '',
        //     maxLines: isExpanded ? 100 : 3,
        //     overflow: TextOverflow.ellipsis,
        //     style: TextStyle(
        //       color: context.theme.colorScheme.secondary.withOpacity(.8),
        //       fontSize: 14,
        //       fontWeight: FontWeight.w400,
        //     )),
      ),
    );
  }
}
