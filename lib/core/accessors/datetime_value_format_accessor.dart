import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../constants/date_format_constant.dart';

class DateTimeValueFormatAccessor extends ControlValueAccessor<DateTime, String> {
  final DateFormat format;

  DateTimeValueFormatAccessor({DateFormat format}) : format = (format ?? DateFormat(ddMMyyyy));
  
  @override
  String  modelToViewValue(DateTime  modelValue) {
   return modelValue == null ? '' : format.format(modelValue);
  }
  
  @override
  DateTime viewToModelValue(String viewValue) {
     return (viewValue == null || viewValue.isEmpty) ? null : format.parse(viewValue);
  }
}
