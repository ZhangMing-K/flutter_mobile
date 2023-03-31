import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AnalyticsActiveItem extends StatelessWidget {
  const AnalyticsActiveItem(
      {Key? key,
      required this.title,
      required this.description,
      required this.iconName,
      required this.onTap})
      : super(key: key);
  final String title;
  final String description;
  final String iconName;
  final Function onTap;

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
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Transform.translate(
                offset: Offset(0, -ScreenUtil().setWidth(10)),
                child: Image.asset(iconName,
                    width: ScreenUtil().setWidth(40),
                    height: ScreenUtil().setWidth(40)),
              )
            ],
          ),
          title: Text(title,
              style: TextStyle(
                  color: context.theme.colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(24))),
          subtitle: Column(
            children: [
              SizedBox(height: ScreenUtil().setWidth(8)),
              Text(description,
                  style: TextStyle(
                      color:
                          context.theme.colorScheme.secondary.withOpacity(0.5),
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.w300))
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
                  child: Icon(
                    Icons.chevron_right,
                    size: ScreenUtil().setWidth(30),
                  ))
            ],
          ),
        ));
  }
}
