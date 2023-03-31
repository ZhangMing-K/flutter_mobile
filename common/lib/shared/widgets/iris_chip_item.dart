import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/providers/local/storage/iris_image_cache_manager.dart';

class IrisChipItem {
  const IrisChipItem({this.name, this.avatarUrl});
  final String? name;
  final String? avatarUrl;
}

class IrisChipChoice extends StatelessWidget {
  const IrisChipChoice({
    Key? key,
    this.choices = const [],
  }) : super(key: key);
  final List<IrisChipItem> choices;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: choices
          .map(
            (item) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: Chip(
                deleteIcon: const Icon(Icons.cancel_outlined),
                avatar: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(item.avatarUrl!,
                      cacheManager: Get.find<IrisImageCacheManager>()),
                ),
                label: Text(item.name!),
                onDeleted: () {
                  choices.removeWhere((name) => name == item);
                },
              ),
            ),
          )
          .toList(),
    );
  }
}
