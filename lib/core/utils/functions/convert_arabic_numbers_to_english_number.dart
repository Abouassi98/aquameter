String convertToEnglishNumbers(String phoneNumber) {
  const arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  for (int index = 0; index < phoneNumber.length; index++) {
    for (int index2 = 0; index2 < arabicNumbers.length; index2++) {
      if (phoneNumber[index] == arabicNumbers[index2]) {
        phoneNumber = replaceCharAt(
          phoneNumber,
          index,
          conevertArabicNumberToStringNumber(arabicNumbers[index2]),
        );
        break;
      }
    }
  }

  return phoneNumber;
}

conevertArabicNumberToStringNumber(String arabicNumber) {
  switch (arabicNumber) {
    case '٠':
      return '0';
    case '١':
      return '1';
    case '٢':
      return '2';
    case '٣':
      return '3';
    case '٤':
      return '4';
    case '٥':
      return '5';
    case '٦':
      return '6';
    case '٧':
      return '7';
    case '٨':
      return '8';
    case '٩':
      return '9';

    default:
      return '3';
  }
}

String replaceCharAt(String oldString, int index, String newChar) {
  return oldString.substring(0, index) +
      newChar +
      oldString.substring(index + 1);
}
