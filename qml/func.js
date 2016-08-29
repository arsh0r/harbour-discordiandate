.pragma library
/**
 * All Hail Discordia! - this script prints Discordian date using system date.
 * author: jklu, arsh0r, lang: JavaScript
 */
var seasons = [qsTr("of Chaos"), qsTr("of Discord"), qsTr("of Confusion"),
  qsTr("of Bureaucracy"), qsTr("of The Aftermath")];

var weekday = [qsTr("Sweetmorn"), qsTr("Boomtime"), qsTr("Pungenday"),
  qsTr("Prickle-Prickle"), qsTr("Setting Orange")];

var apostle = [qsTr("Mungday"), qsTr("Mojoday"), qsTr("Syaday"),
  qsTr("Zaraday"), qsTr("Maladay")];

var holiday = [qsTr("Chaoflux"), qsTr("Discoflux"), qsTr("Confuflux"),
  qsTr("Bureflux"), qsTr("Afflux")];


Date.prototype.isLeapYear = function() {
  var year = this.getFullYear();
  if ((year & 3) !== 0) return false;
  return ((year % 100) !== 0 || (year % 400) === 0);
};

// Get Day of Year
Date.prototype.getDOY = function() {
  var dayCount = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
  var mn = this.getMonth();
  var dn = this.getDate();
  var dayOfYear = dayCount[mn] + dn;
  if (mn > 1 && this.isLeapYear()) dayOfYear++;
  return dayOfYear;
};

function discordianDate(date,cover) {
  var y = date.getFullYear();
  var dayOfYear = date.getDOY();
  var yold;
  cover = cover || false;

  if (!cover) {
    yold = qsTr("in the Year of Our Lady of Discord %1").arg(y + 1166)
  }
  else {
    yold = qsTr("in the YOLD %1").arg(y + 1166)
  }

  if (date.isLeapYear()) {
    if (dayOfYear == 60)
      return qsTr("St. Tib's Day") + ", " + yold;
    else if (dayOfYear > 60)
      dayOfYear--;
  }
  dayOfYear--;

  var divDay= Math.floor(dayOfYear/73);

  var seasonDay = (dayOfYear % 73) + 1;
  if (seasonDay == 5)
    return apostle[divDay] + ", " + yold;
  if (seasonDay == 50)
    return holiday[divDay] + ", " + yold;

  var season = seasons[divDay];
  var dayOfWeek = weekday[dayOfYear % 5];



  return dayOfWeek + ", "+ qsTr("day")+ " " + seasonDay + " " +
    season + " " + yold;
}

function daysuntilcelebrate(date) {
  var dayOfYear = date.getDOY();
  var addone = 0;
  var days;

  if (date.isLeapYear()) {
    if (dayOfYear > 60) {
      dayOfYear--;
    }
    else {
      addone = 1; //consider St. Tib's Day
    }
  }
  dayOfYear--;

  var divDay= Math.floor(dayOfYear/73);
  var seasonDay = (dayOfYear % 73) + 1;

  if (seasonDay < 5) {
      days = 5-seasonDay;
      if (days > 1)
        return qsTr("%1 days until").arg(days) + " " + apostle[divDay];
      else
        return qsTr("%1 day until").arg(days) + " " + apostle[divDay];
  }
  else if (seasonDay == 5) {
      return qsTr("Celebrate %1!").arg(apostle[divDay]);
  }
  else if (seasonDay < 50) {
      days = 50-seasonDay;
      if (days > 1)
        return qsTr("%1 days until").arg(days) + " " + holiday[divDay];
      else
        return qsTr("%1 day until").arg(days) + " " + holiday[divDay];
  }
  else if (seasonDay == 50) {
      return qsTr("Celebrate %1!").arg(holiday[divDay]);
  }
  else if (seasonDay > 50) {
      days = 73-seasonDay+5+addone;
      if (days > 1)
        return qsTr("%1 days until").arg(days) + " " + apostle[(divDay+1) % 5];
      else
        return qsTr("%1 day until").arg(days) + " " + apostle[(divDay+1) % 5];
  }
}
