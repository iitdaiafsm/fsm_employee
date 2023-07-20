import 'package:flutter/material.dart';
import 'package:fsm_employee/helper/date_format_helper.dart';
import 'package:fsm_employee/helper/flutter_bounce.dart';
import 'package:fsm_employee/helper/models/agenda_model.dart';
import 'package:fsm_employee/widget/button.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../helper/styles.dart';
import '../main/main_logic.dart';
import 'my_leaves_logic.dart';

class MyLeavesPage extends StatelessWidget {
  MyLeavesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Leaves",
          style: textStyle(
            context: context,
            fontSize: FontSize.H2,
            isBold: true,
          ),
        ),
        SizedBox(height: 10),
        Expanded(
            child: GetBuilder<MyLeavesLogic>(
          init: MyLeavesLogic(),
          id: "leave",
          builder: (logic) {
            return logic.isLoading
                ? Center(
                    child: Lottie.asset("asset/lottie/loading.json",
                        width: width(context) * 0.8, fit: BoxFit.contain))
                : logic.leaves.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "You have not applied for any leaves yet. Good job!",
                            style: textStyle(
                              context: context,
                              fontSize: FontSize.TITLE,
                              isBold: true,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          AppButton(
                            text: "Apply Now!",
                            onTap: () {
                              MainLogic mainLogic =
                                  Get.put<MainLogic>(MainLogic());
                              mainLogic.changePage("Apply Leave");
                            },
                          )
                        ],
                      )
                    : ListView(
                        children: List.generate(
                            logic.leaves.length,
                            (index) => logic.leaves[index].version == "V1"
                                ? getLeaveItemV1(
                                    context, logic.leaves[index], logic)
                                : getLeaveItemV2(
                                    context, logic.leaves[index], logic)),
                      );
          },
        )),
        SizedBox(height: 10),
      ],
    );
  }

  Widget getLeaveItemV1(
      BuildContext context, AgendaModel leave, MyLeavesLogic logic) {
    double days = double.parse(
        (((leave.endDate?.difference(leave.startDate ?? DateTime.now()) ??
                        const Duration())
                    .inMinutes) /
                1440)
            .toStringAsFixed(1));
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${days > 1 ? 'Start' : 'Date'} : ",
                              style: textStyle(
                                  context: context,
                                  isBold: true,
                                  color: Theme.of(context).primaryColorDark),
                            ),
                            Text(
                              DateFormatHelper.convertDateFromDate(
                                  leave.startDate ?? DateTime.now(),
                                  "dd-MM-yyyy hh:mm a"),
                              style: textStyle(
                                  context: context,
                                  color: Theme.of(context).primaryColorDark),
                            )
                          ],
                        ),
                        if (days > 1)
                          Row(
                            children: [
                              Text(
                                "End : ",
                                style: textStyle(
                                    context: context,
                                    isBold: true,
                                    color: Theme.of(context).primaryColorDark),
                              ),
                              Text(
                                DateFormatHelper.convertDateFromDate(
                                    leave.endDate ?? DateTime.now(),
                                    "dd-MM-yyyy hh:mm a"),
                                style: textStyle(
                                    context: context,
                                    color: Theme.of(context).primaryColorDark),
                              )
                            ],
                          )
                      ],
                    ),
                  ),
                  Text(
                    "$days ${days > 1 ? 'Days' : 'Day'}",
                    style: textStyle(
                        context: context,
                        isBold: true,
                        fontSize: FontSize.H1,
                        color: Theme.of(context).primaryColorDark),
                  ),
                ],
              ),
              Divider(),
              Text(
                leave.reason ?? "",
                style: textStyle(
                    context: context,
                    isBold: false,
                    color: Theme.of(context).primaryColorDark),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: getColor(leave.status ?? ""),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      leave.status ?? "",
                      style: textStyle(context: context, fontSize: FontSize.H6),
                    ),
                  ),
                  if ((leave.startDate??DateTime.now()).isAfter(DateTime.now()) && leave.status !="Deleted")
                    Bounce(
                      onPressed: () {
                        if(!logic.isDeleteButtonLoading){
                          logic.deleteLeave(context, leave);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red[800]!,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.all(5),
                        child: Opacity(
                          opacity: logic.isDeleteButtonLoading?0:1,
                          child: Text(
                            "Delete",
                            style: textStyle(
                              context: context,
                              fontSize: FontSize.H5,
                              isBold: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
        Divider(
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  Widget getLeaveItemV2(
      BuildContext context, AgendaModel leave, MyLeavesLogic logic) {
    double daysCount =
        (((leave.endDate?.difference(leave.startDate ?? DateTime.now()) ??
                        const Duration())
                    .inMinutes) /
                1440) +
            1;
    if (leave.startHalfDay ?? false) {
      daysCount = daysCount - 0.5;
    }
    if (leave.endHalfDay ?? false) {
      daysCount = daysCount - 0.5;
    }
    double days = double.parse((daysCount).toStringAsFixed(1));
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${days > 1 ? 'Start' : 'Date'} : ",
                              style: textStyle(
                                  context: context,
                                  isBold: true,
                                  color: Theme.of(context).primaryColorDark),
                            ),
                            Text(
                              DateFormatHelper.convertDateFromDate(
                                  leave.startDate ?? DateTime.now(),
                                  "dd-MM-yyyy"),
                              style: textStyle(
                                  context: context,
                                  color: Theme.of(context).primaryColorDark),
                            )
                          ],
                        ),
                        if (leave.endDate != null)
                          Row(
                            children: [
                              Text(
                                "End : ",
                                style: textStyle(
                                    context: context,
                                    isBold: true,
                                    color: Theme.of(context).primaryColorDark),
                              ),
                              Text(
                                DateFormatHelper.convertDateFromDate(
                                    leave.endDate ?? DateTime.now(),
                                    "dd-MM-yyyy"),
                                style: textStyle(
                                    context: context,
                                    color: Theme.of(context).primaryColorDark),
                              )
                            ],
                          )
                      ],
                    ),
                  ),
                  Text(
                    "$days ${days > 1 ? 'Days' : 'Day'}",
                    style: textStyle(
                        context: context,
                        isBold: true,
                        fontSize: FontSize.H1,
                        color: Theme.of(context).primaryColorDark),
                  ),
                ],
              ),
              Divider(),
              Text(
                leave.reason ?? "",
                style: textStyle(
                    context: context,
                    isBold: false,
                    color: Theme.of(context).primaryColorDark),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: getColor(leave.status ?? ""),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      leave.status ?? "",
                      style: textStyle(context: context, fontSize: FontSize.H6),
                    ),
                  ),
                  if ((leave.startDate??DateTime.now()).isAfter(DateTime.now()) && leave.status !="Deleted")
                    Bounce(
                      onPressed: () {
                        if(!logic.isDeleteButtonLoading){
                          logic.deleteLeave(context, leave);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red[800]!,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.all(5),
                        child: Opacity(
                          opacity: logic.isDeleteButtonLoading?0:1,
                          child: Text(
                            "Delete",
                            style: textStyle(
                              context: context,
                              fontSize: FontSize.H5,
                              isBold: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  Color getColor(String status) {
    switch (status) {
      case "Pending":
        return Colors.yellow[800]!;
      case "Approved":
        return Colors.green[800]!;
      case "Reject":
        return Colors.red[800]!;
      case "Deleted":
        return Colors.grey[800]!;
      default:
        return Colors.yellow[800]!;
    }
  }
}
