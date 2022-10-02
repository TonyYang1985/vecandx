class DateTimeUtil {
  static int getAge(DateTime birthDate) {
    if (birthDate != null) {
      var currentDate = DateTime.now();
      var age = currentDate.year - birthDate.year;
      var month1 = currentDate.month;
      var month2 = birthDate.month;
      if (month2 > month1) {
        age--;
      } else if (month1 == month2) {
        var day1 = currentDate.day;
        var day2 = birthDate.day;
        if (day2 > day1) {
          age--;
        }
      }
      return age;
    }
    return null;
  }
}