import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../core/accessors/datetime_value_format_accessor.dart';

class DateRangeWidget extends StatelessWidget {
  final String fromControlName;
  final String toControlName;
  final String rangeName;
  final Function onClear;

  const DateRangeWidget({
    Key key,
    this.fromControlName = 'from',
    this.toControlName = 'to',
    this.rangeName = 'Date Range',
    this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(rangeName),
        SizedBox(height: 3),
        Row(
          children: [
            Container(
              width: 150,
              child: ReactiveTextField(
                formControlName: fromControlName,
                valueAccessor: DateTimeValueFormatAccessor(),
                readOnly: true,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'From',
                  border: OutlineInputBorder(),
                  suffixIcon: ReactiveDatePicker(
                    formControlName: fromControlName,
                    firstDate: DateTime(DateTime.now().year - 10),
                    lastDate: DateTime(DateTime.now().year + 10),
                    builder: (context, picker, child) {
                      return IconButton(
                        icon: Icon(Icons.access_time),
                        onPressed: picker.showPicker,
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              width: 150,
              child: ReactiveTextField(
                formControlName: toControlName,
                valueAccessor: DateTimeValueFormatAccessor(),
                readOnly: true,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'To',
                  border: OutlineInputBorder(),
                  suffixIcon: ReactiveDatePicker(
                    formControlName: toControlName,
                    firstDate: DateTime(DateTime.now().year - 10),
                    lastDate: DateTime(DateTime.now().year + 10),
                    builder: (context, picker, child) {
                      return IconButton(
                        icon: Icon(Icons.access_time),
                        onPressed: picker.showPicker,
                      );
                    },
                  ),
                ),
              ),
            ),
            ReactiveFormConsumer(
              builder: (context, form, child) {
                final from = form.control(fromControlName);
                final to = form.control(toControlName);
                final widget = from.value != null || to.value != null
                    ? IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          from.patchValue(null);
                          to.patchValue(null);
                          if (onClear != null) onClear();
                        },
                        tooltip: 'Clear',
                      )
                    : SizedBox(width: 10);
                return widget;
              },
            ),
          ],
        ),
      ],
    );
  }
}
