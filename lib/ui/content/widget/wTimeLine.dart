import 'package:Pasaporte_2020/model/content/display.dart';
import 'package:Pasaporte_2020/model/content/time_line_conf.dart';
import 'package:Pasaporte_2020/utils/ColorUtils.dart';
import 'package:Pasaporte_2020/utils/ImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class WTimeline extends StatefulWidget {
  WTimeline(
      {Key key,
      this.title,
      this.bgColorParent,
      this.display,
      this.timeLineConf,
      this.lines})
      : super(key: key);
  final String title;
  final Color bgColorParent;
  final Display display;
  final TimeLineConf timeLineConf;
  final List<Line> lines;

  @override
  _WTimelineState createState() => _WTimelineState();
}

class _WTimelineState extends State<WTimeline> {
  @override
  Widget build(BuildContext context) {
    final String wPosition = widget.timeLineConf.linePosition;
    TimelinePosition position;
    if (wPosition == null || wPosition == "right")
      position = TimelinePosition.Right;
    else if (wPosition == "left")
      position = TimelinePosition.Left;
    else if (wPosition == "center") position = TimelinePosition.Center;

    Color lineColor = getBackgroundColor(
        context, widget.timeLineConf.lineColor, Colors.white);
    Color tlBgColor = getBackgroundColor(
        context, widget.timeLineConf.backgroundColor, widget.bgColorParent);
    var timeLine = timelineModel(position, lineColor);

    return Container(
      height: 200.0 * widget.lines.length,
      child: timeLine,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
        decoration: new BoxDecoration(
            color: tlBgColor, //new Color.fromRGBO(255, 0, 0, 0.0),
            borderRadius: new BorderRadius.all(Radius.circular(19)),
        )
    );
  }

  timelineModel(TimelinePosition position, Color lineColor) => Timeline.builder(
      itemBuilder: centerTimelineBuilder,
      itemCount: widget.lines.length,
      lineColor: lineColor,
      position: position);

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final Color dTextColor =
        getTextColor(context, widget.timeLineConf.textColor);
    final String dFontFamily = widget.timeLineConf.fontFamily;
    final double dFontSize = widget.timeLineConf.fontSize;

    final timeLine = widget.lines[i];
    Color dBackgroundColor = getBackgroundColor(
        context, timeLine.backgroundColor, widget.bgColorParent);

    final Color titleColor = (timeLine.titleColor == null
        ? dTextColor
        : getTextColor(context, timeLine.titleColor));
    final String titleFontFamily = (timeLine.titleFontFamily == null
        ? dFontFamily
        : timeLine.titleFontFamily);
    final double titleFontSize =
        (timeLine.titleFontSize == null ? dFontSize : timeLine.titleFontSize);
    TextStyle titleStyle = TextStyle(
        color: titleColor,
        fontFamily: titleFontFamily,
        fontSize: titleFontSize);

    final Color timeColor = (timeLine.timeColor == null
        ? dTextColor
        : getTextColor(context, timeLine.timeColor));
    final String timeFontFamily = (timeLine.timeFontFamily == null
        ? dFontFamily
        : timeLine.timeFontFamily);
    final double timeFontSize =
        (timeLine.timeFontSize == null ? dFontSize : timeLine.timeFontSize);
    TextStyle timeStyle = TextStyle(
        color: timeColor, fontFamily: timeFontFamily, fontSize: timeFontSize);
    print("Code Pint ${Icons.star.codePoint}");
    final Color iconColor = getTextColor(
        context, widget.timeLineConf.iconColor, Colors.black);


    Icon icono;
    if (i == (widget.lines.length - 1)) {
      icono = Icon(
        Icons.av_timer,
        color: iconColor,
      );
    } else if (i == 0) {
      icono = Icon(Icons.access_time, color: iconColor);
    } else {
      icono = Icon(Icons.timelapse, color: iconColor);
    }

    if (timeLine.image == null || timeLine.image.isEmpty) {
      return TimelineModel(
          Card(
            color: dBackgroundColor,
            margin: EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 8.0,
                  ),
                  Container(
                      child: Text(
                    timeLine.time,
                    overflow: TextOverflow.visible,
                    style: timeStyle,
                  )),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                      child: Text(
                    timeLine.title,
                    overflow: TextOverflow.visible,
                    style: titleStyle,
                    textAlign: TextAlign.left,
                  )),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ),
          position: (timeLine.position == null || timeLine.position == 'right'
              ? TimelineItemPosition.right
              : TimelineItemPosition.left),
          isFirst: i == 0,
          isLast: i == widget.lines.length,
          iconBackground: dBackgroundColor,
          icon: icono);
    }

    return TimelineModel(
        Card(
          color: dBackgroundColor,
          margin: EdgeInsets.symmetric(vertical: 16.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                (timeLine.image != null
                    ? getImageContent(url: timeLine.image)
                    : SizedBox()),
                (timeLine.image != null
                    ? SizedBox(
                        height: 8.0,
                      )
                    : SizedBox()),
                Text(
                  timeLine.time,
                  style: timeStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  timeLine.title,
                  style: titleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
        ),
        position: (timeLine.position == null || timeLine.position == 'right'
            ? TimelineItemPosition.right
            : TimelineItemPosition.left),
        isFirst: i == 0,
        isLast: i == widget.lines.length,
        iconBackground: widget.bgColorParent,
        icon: icono);
  }
}
