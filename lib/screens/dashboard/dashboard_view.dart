import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../helper/calender_data_source.dart';
import '../../helper/styles.dart';
import 'dashboard_logic.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GetBuilder<DashboardLogic>(
          init: DashboardLogic(),
          id: "greeting",
          builder: (logic) {
            return Text(
              logic.greetingMessage,
              style: textStyle(
                context: context,
                fontSize: FontSize.H2,
                isBold: true,
              ),
            );
          },
        ),
        SizedBox(height: 10),
        Expanded(
            child: GetBuilder<DashboardLogic>(
              init: DashboardLogic(),
              id: "calender",
              builder: (logic) {
                return Container(
                  color: Colors.white,
                  child: StreamBuilder<AgendaDataSource>(
                      stream: logic.agendaDataSourceStream.stream,
                      builder: (context, snapshot) {
                        return snapshot.data != null
                            ? SizedBox(
                          height: height(context) * 0.9,
                          child: SfCalendar(
                            controller: logic.calendarController,
                            todayTextStyle: textStyle(context: context,color: Theme.of(context).primaryColor,fontSize: FontSize.H1,isBold: true,),
                            dataSource: snapshot.data,
                            view: CalendarView.month,
                            monthViewSettings: MonthViewSettings(
                                appointmentDisplayMode:
                                MonthAppointmentDisplayMode
                                    .appointment,
                                showAgenda: true,
                                showTrailingAndLeadingDates: false,
                                dayFormat: 'EEE',
                                agendaItemHeight: 70,
                                agendaStyle: AgendaStyle(
                                  appointmentTextStyle: textStyle(
                                    context: context,
                                    fontSize: FontSize.H5,
                                    isBold: false,
                                  ),
                                  dateTextStyle: textStyle(
                                    context: context,
                                    fontSize: FontSize.H4,
                                    isBold: true,
                                    color: Theme.of(context)
                                        .primaryColorDark,
                                  ),
                                  dayTextStyle: textStyle(
                                    context: context,
                                    fontSize: FontSize.H4,
                                    isBold: true,
                                    color: Theme.of(context)
                                        .primaryColorDark,
                                  ),
                                ),
                                monthCellStyle: MonthCellStyle(
                                  textStyle: textStyle(context: context,color: Theme.of(context).primaryColorDark,fontSize: FontSize.H1,),
                                )
                            ),
                          ),
                        )
                            : SizedBox(
                          width: 0,
                          height: 0,
                        );
                      }),
                );
              },
            )),
        SizedBox(height: 10),
      ],
    );
  }
}
