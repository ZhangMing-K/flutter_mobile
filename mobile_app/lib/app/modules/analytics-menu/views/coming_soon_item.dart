import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AnalyticsComingItem extends StatelessWidget {
  final String title;
  final Function onTap;
  const AnalyticsComingItem(
      {Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: context.theme.backgroundColor),
        padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setWidth(10), horizontal: 0),
        margin: EdgeInsets.only(top: ScreenUtil().setWidth(8)),
        child: ListTile(
          onTap: () {
            onTap();
          },
          title: FittedBox(
            child: Row(
              children: [
                Text(title,
                    style: TextStyle(
                        color: context.theme.colorScheme.secondary
                            .withOpacity(0.4),
                        fontWeight: FontWeight.bold,
                        fontSize: 24)),
                Transform.translate(
                    offset: const Offset(0, 3),
                    child: Text('   (Coming soon)',
                        style: TextStyle(
                            color: context.theme.colorScheme.secondary
                                .withOpacity(0.4),
                            fontWeight: FontWeight.w700,
                            fontSize: 14)))
              ],
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
                  child: Icon(
                    Icons.chevron_right,
                    color: context.theme.colorScheme.secondary.withOpacity(0.4),
                    size: ScreenUtil().setWidth(30),
                  ))
            ],
          ),
        ));
  }
}
