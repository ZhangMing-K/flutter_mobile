import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_common/iris_common.dart';

import '../../channel_tile/views/channel_tile.dart';

class CategoryTile extends StatelessWidget {
  final Workspace workspace;

  final bool showContent;
  const CategoryTile(
      {required this.workspace, this.showContent = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IrisAccordion(
        margin: EdgeInsets.zero,
        showAccordion: showContent,
        titleChild: Text(
          workspace.name!,
          style: const TextStyle(fontSize: 18),
        ),
        titlePadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.only(top: 10),
        collapsedIcon: Icon(Icons.chevron_right,
            color: context.theme.colorScheme.secondary),
        expandedIcon: Icon(Icons.keyboard_arrow_down,
            color: context.theme.colorScheme.secondary),
        collapsedTitleBackgroundColor: context.theme.scaffoldBackgroundColor,
        expandedTitleBackgroundColor: context.theme.scaffoldBackgroundColor,
        contentBackgroundColor: context.theme.scaffoldBackgroundColor,
        contentChild: Container(
          padding: const EdgeInsets.only(top: 12),
          child: ListView.separated(
            addAutomaticKeepAlives: false,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: workspace.authUserChildren!.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final Workspace channel = workspace.authUserChildren![index];

              final Widget tile = channel.workspaceType == WORKSPACE_TYPE.TEXT
                  ? ChannelTile(
                      workspace: channel, key: Key('${channel.workspaceKey}'))
                  : Container();
              return Container(
                  padding: const EdgeInsets.only(left: 12), child: tile);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 12,
              );
            },
          ),
        ));
  }
}
