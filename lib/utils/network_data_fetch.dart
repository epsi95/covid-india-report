import 'package:covid_india_report/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Map<String, int> month = {
  "JANUARY": 01,
  "FEBRUARY": 02,
  "MARCH": 03,
  "APRIL": 04,
  "MAY": 05,
  "JUNE": 06,
  "JULY": 07,
  "AUGUST": 08,
  "SEPTEMBER": 09,
  "OCTOBER": 10,
  "NOVEMBER": 11,
  "DECEMBER": 12
};

// check if d1-m1 is greater than d2-m2
bool isGreater(int d1, int m1, int d2, int m2) {
  print(d1);
  print(m1);
  print(d2);
  print(m2);
  if (m2 < m1) {
    return true;
  } else if (m2 == m1) {
    if (d1 >= d2) {
      return true;
    }
  }
  return false;
}

Future getAllIndiaData() async {
  var dataToBeSent = [];
  Map<String, int> dailyConfirmed = {};
  Map<String, int> dailyActive = {};
  Map<String, int> dailyRecovered = {};
  Map<String, int> dailyDeceased = {};

  int totalConfirmed = 0;
  int totalActive = 0;
  int totalRecovered = 0;
  int totalDeceased = 0;

  String confirmedDelta = "n";
  String activeDDelta = "n";
  String recoveredDelta = "n";
  String deceasedDelta = "n";

  String lastUpdateddate = "";

  var response = await http.get(kAllIndiaDataUrl);
  var response2 = await http.get(kStateDataUrl);

  if (response.statusCode == 200) {
    try {
      var totalData = convert.jsonDecode(response.body);
      var data = totalData["cases_time_series"];

      String dateInFirst = data[data.length - 1]["date"];
      String dateInSecond = totalData["statewise"][0]["lastupdatedtime"];

      try {
        int d1 = int.parse(dateInFirst.split(" ")[0]);
        int m1 = month[(dateInFirst.split(" ")[1]).toUpperCase()];

        int d2 = int.parse(dateInSecond.split("/")[0]);
        int m2 = int.parse(dateInSecond.split("/")[1]);

        bool result = isGreater(d2, m2, d1, m1);
        if (result) {
          data.add({
            "dailyconfirmed": totalData["statewise"][0]["deltaconfirmed"],
            "dailydeceased": totalData["statewise"][0]["deltadeaths"],
            "dailyrecovered": totalData["statewise"][0]["deltarecovered"],
            "date": totalData["statewise"][0]["lastupdatedtime"],
            "totalconfirmed": totalData["statewise"][0]["confirmed"],
            "totaldeceased": totalData["statewise"][0]["deaths"],
            "totalrecovered": totalData["statewise"][0]["recovered"]
          });
          confirmedDelta =
              getDeltaNew(totalData["statewise"][0]["deltaconfirmed"]);
          recoveredDelta =
              getDeltaNew(totalData["statewise"][0]["deltarecovered"]);
          deceasedDelta = getDeltaNew(totalData["statewise"][0]["deltadeaths"]);
//          activeDDelta = getDeltaNew((int.parse(confirmedDelta) -
//                  (int.parse(recoveredDelta) + int.parse(deceasedDelta)))
//              .toString());
//          print("%");
          activeDDelta = "";
          print(confirmedDelta + recoveredDelta + deceasedDelta + activeDDelta);
        }
      } catch (e) {
        print(e);
      }
//      if (int.parse(data[data.length - 1]["totalconfirmed"]) <
//          int.parse(totalData["statewise"][0]["confirmed"])) {
//        data.add({
//          "dailyconfirmed": totalData["statewise"][0]["deltaconfirmed"],
//          "dailydeceased": totalData["statewise"][0]["deltadeaths"],
//          "dailyrecovered": totalData["statewise"][0]["deltarecovered"],
//          "date": totalData["statewise"][0]["lastupdatedtime"],
//          "totalconfirmed": totalData["statewise"][0]["confirmed"],
//          "totaldeceased": totalData["statewise"][0]["deaths"],
//          "totalrecovered": totalData["statewise"][0]["recovered"]
//        });
//      }
      for (var each in data) {
        dailyConfirmed[each["date"].trim()] = int.parse(each["dailyconfirmed"]);
        dailyDeceased[each["date"].trim()] = int.parse(each["dailydeceased"]);
        dailyRecovered[each["date"].trim()] = int.parse(each["dailyrecovered"]);
        dailyActive[each["date"].trim()] = (int.parse(each["dailyconfirmed"]) -
                (int.parse(each["dailydeceased"]) +
                    int.parse(each["dailyrecovered"])))
            .abs();
      }
      print("###ok1");
      totalConfirmed = int.parse(data[data.length - 1]["totalconfirmed"]);
      totalRecovered = int.parse(data[data.length - 1]["totalrecovered"]);
      totalDeceased = int.parse(data[data.length - 1]["totaldeceased"]);
      totalActive = totalConfirmed - (totalRecovered + totalDeceased);
      print("###ok2");
      if (confirmedDelta == "n") {
        confirmedDelta = getDelta(
            int.parse(data[data.length - 2]["totalconfirmed"]), totalConfirmed);
        recoveredDelta = getDelta(
            int.parse(data[data.length - 2]["totalrecovered"]), totalRecovered);
        deceasedDelta = getDelta(
            int.parse(data[data.length - 2]["totaldeceased"]), totalDeceased);
//        int pastActive = int.parse(data[data.length - 2]["totalconfirmed"]) -
//            (int.parse(data[data.length - 2]["totalrecovered"]) +
//                int.parse(data[data.length - 2]["totaldeceased"]));
//        activeDDelta = getDelta(pastActive, totalActive);
        activeDDelta = "";
      }

      lastUpdateddate = data[data.length - 1]["date"].trim();

      var requiredData = [
        dailyConfirmed,
        dailyActive,
        dailyRecovered,
        dailyDeceased,
        totalConfirmed,
        totalActive,
        totalRecovered,
        totalDeceased,
        confirmedDelta,
        activeDDelta,
        recoveredDelta,
        deceasedDelta,
        lastUpdateddate
      ];
//      print(requiredData);
//      return requiredData;
      dataToBeSent.add(requiredData);
    } catch (e) {
      print("Unable to parse");
      print(e);
      return ["Error", "Unable to parse."];
    }
  } else {
    print("Status code not 200");
    return ["Error", "Unable to fetch data."];
  }

  if (response2.statusCode == 200) {
    try {
      Map<String, List<List<dynamic>>> stateData = {};
      List<List<dynamic>> districtDump = [];

      var totalData = convert.jsonDecode(response2.body);
      totalData.forEach((k, v) {
//        print(k);
//        print(v);
        districtDump.clear();
        v["districtData"].forEach((distName, distData) {
//          print(distName);
//          print(distData);
          districtDump.add([distName, distData["confirmed"]]);
        });
        stateData[k] = List.from(districtDump);
      });
      var sortedKeys = stateData.keys.toList()..sort();
      Map<String, List<List<dynamic>>> newStateData = {};
      for (var i in sortedKeys) {
        newStateData[i] = stateData[i];
      }
//      print("%%%state data");
//      print(stateData);
      dataToBeSent.add(newStateData);
    } catch (e) {
      print("Unable to parse");
      print(e);
      return ["Error", "Unable to parse."];
    }
  } else {
    print("Status code not 200");
    return ["Error", "Unable to fetch data."];
  }

  return dataToBeSent;
}

String getDelta(int past, int now) {
  if (now < past) {
    return ("[ -" + (past - now).toString() + " ]");
  } else {
    return ("[ +" + (now - past).toString() + " ]");
  }
}

String getDeltaNew(String val) {
  int v = int.parse(val);
  if (v < 0) {
    return ("[ -" + val + " ]");
  } else {
    return ("[ +" + val + " ]");
  }
}
