import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fsm_employee/helper/date_format_helper.dart';
import 'package:fsm_employee/widget/button.dart';
import 'package:fsm_employee/widget/text_field_container.dart';
import 'package:get/get.dart';

import '../../helper/styles.dart';
import '../../widget/date_time_picker.dart';
import 'apply_leave_logic.dart';

class ApplyLeavePage extends StatelessWidget {
  ApplyLeavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Apply Leave",
          style: textStyle(
            context: context,
            fontSize: FontSize.H2,
            isBold: true,
          ),
        ),
        SizedBox(height: 10),
        Expanded(
            child: GetBuilder<ApplyLeaveLogic>(
          init: ApplyLeaveLogic(),
          builder: (logic) {
            return Container(
              width: width(context),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(10),
              child: Form(
                key: logic.formKey,
                child: ListView(
                  children: [
                    TextFieldContainer(
                      textEditingController: logic.reasonController,
                      title: "Reason *",
                      hint: "Enter leave reason",
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return "Enter leave reason";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DateTimePicker(
                      type: DateTimePickerType.date,
                      dateMask: 'dd-MM-yyyy',
                      controller: logic.startDateController,
                      firstDate: DateTime.now().subtract(Duration(days: 500)),
                      lastDate: DateTime.now().add(Duration(days: 500)),
                      initialDate: DateTime.now(),
                      decoration: InputDecoration(
                        labelText: "Select start date *",
                        isDense: false,
                        hintText: "Select start date *",
                        hintStyle: textStyle(
                            context: context,
                            color: Theme.of(context).focusColor),
                        labelStyle: textStyle(
                            context: context,
                            color: Theme.of(context).cardColor),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        contentPadding: EdgeInsets.all(8),
                      ),
                      timeLabelText: "Hour",
                      selectableDayPredicate: (date) {
                        // Disable weekend days to select from the calendar
                        if (date.weekday == 6 || date.weekday == 7) {
                          return false;
                        }

                        return true;
                      },
                      // onChanged: (val) => print(val),
                      validator: (val) {
                        if (val?.isEmpty ?? false) {
                          return "Select Start Date";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CheckboxListTile(
                      value: logic.isHalfDayStart,
                      onChanged: (value) {
                        if (logic.startDateController.text.trim().isEmpty) {
                          Fluttertoast.showToast(
                              msg: "First select Start Date");
                          return;
                        }
                        logic.isHalfDayStart = value!;
                        logic.update();
                      },
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "Start Half Day",
                        style: textStyle(
                            context: context,
                            color: Theme.of(context).cardColor),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DateTimePicker(
                      type: DateTimePickerType.date,
                      dateMask: 'dd-MM-yyyy',
                      controller: logic.endDateController,
                      firstDate: DateTime.now().subtract(Duration(days: 500)),
                      lastDate: DateTime.now().add(Duration(days: 500)),
                      initialDate: DateTime.now(),

                      decoration: InputDecoration(
                        labelText: "Select end date (optional)",
                        isDense: false,
                        hintText: "Select end date (optional)",
                        hintStyle: textStyle(
                            context: context,
                            color: Theme.of(context).focusColor),
                        labelStyle: textStyle(
                            context: context,
                            color: Theme.of(context).cardColor),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        contentPadding: EdgeInsets.all(8),
                      ),
                      timeLabelText: "Hour",
                      selectableDayPredicate: (date) {
                        // Disable weekend days to select from the calendar
                        if (date.weekday == 6 || date.weekday == 7) {
                          return false;
                        }

                        return true;
                      },
                      // onChanged: (val) => print(val),
                      validator: (val) {
                        if (val?.isNotEmpty ?? false) {
                          DateTime startDate =
                              DateFormatHelper.convertToDateFromString(
                                  logic.startDateController.text,
                                  "yyyy-MM-dd");
                          DateTime endDate =
                              DateFormatHelper.convertToDateFromString(
                                  val ?? "", "yyyy-MM-dd");
                          var day =
                              ((endDate.difference(startDate)).inMinutes) /
                                  1440;

                          if (day < 0.25) {
                            return "End date should greater than start date";
                          }
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CheckboxListTile(
                      value: logic.isHalfDayEnd,
                      onChanged: (value) {
                        if (logic.endDateController.text.trim().isEmpty) {
                          Fluttertoast.showToast(msg: "First select End Date");
                          return;
                        }
                        logic.isHalfDayEnd = value!;
                        logic.update();
                      },
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "End Half Day",
                        style: textStyle(
                            context: context,
                            color: Theme.of(context).cardColor),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AppButton(
                      text: "Submit",
                      onTap: () {
                        logic.onSubmit(context);
                      },
                      isLoading: logic.isLoading,
                    )
                  ],
                ),
              ),
            );
          },
        )),
        SizedBox(height: 10),
      ],
    );
  }
}
