import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:todo/config/themes/my_drawing.dart';
import 'package:todo/data/media_query/media_query.dart';

class Calendar extends StatelessWidget {
  final Function(String date) onSubmit;
  const Calendar({Key? key, required this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.white,
        ),
        height: context.width - 50,
        width: context.width - 50,
        child: SfDateRangePicker(
            enablePastDates: false,
            showActionButtons: true,
            onCancel: () => Navigator.pop(context),
            onSubmit: (date) {
              if (date != null) {
                onSubmit(date.toString().substring(0, 10));
              }
              Navigator.pop(context);
            },
            selectionMode: DateRangePickerSelectionMode.single),
      ),
    );
  }
}
