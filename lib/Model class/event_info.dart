// // To parse this JSON data, do
// //
// //     final eventInfo = eventInfoFromJson(jsonString);

// import 'dart:convert';

// EventInfo eventInfoFromJson(String str) => EventInfo.fromJson(json.decode(str));

// String eventInfoToJson(EventInfo data) => json.encode(data.toJson());

// class EventInfo {
//   Eventdata eventdata;
//   String responseCode;
//   String result;
//   String responseMsg;

//   EventInfo({
//     required this.eventdata,
//     required this.responseCode,
//     required this.result,
//     required this.responseMsg,
//   });

//   factory EventInfo.fromJson(Map<String, dynamic> json) => EventInfo(
//         eventdata: Eventdata.fromJson(json["Eventdata"]),
//         responseCode: json["ResponseCode"],
//         result: json["Result"],
//         responseMsg: json["ResponseMsg"],
//       );

//   Map<String, dynamic> toJson() => {
//         "Eventdata": eventdata.toJson(),
//         "ResponseCode": responseCode,
//         "Result": result,
//         "ResponseMsg": responseMsg,
//       };
// }

// class Eventdata {
//   String eventId;
//   String eventTitle;
//   String eventCoverImg;
//   String eventImage;
//   String eventStatus;
//   DateTime eventStartDate;
//   String eventStartTime;
//   String eventEndTime;
//   String eventAddress;
//   String eventDescription;
//   String eventDisclaimer;
//   String eventLatitude;
//   String eventLongtitude;
//   String eventProgress;
//   String eventPlaceName;
//   String eventFacilityId;
//   String eventRestictId;
//   String eventTags;
//   String eventVurls;
//   int totalTicket;
//   int totalBookTicket;
//   List<String> gallerydata;
//   List<Artistdatum> artistdata;
//   List<Facilitydatum> facilitydata;
//   List<Restrictiondatum> restrictiondata;
//   List<JoinedUser> joinedUser;
//   List<dynamic> attendUser;
//   List<JoinedUser> notjoinedUser;
//   List<TotalReview> totalReview;

//   Eventdata({
//     required this.eventId,
//     required this.eventTitle,
//     required this.eventCoverImg,
//     required this.eventImage,
//     required this.eventStatus,
//     required this.eventStartDate,
//     required this.eventStartTime,
//     required this.eventEndTime,
//     required this.eventAddress,
//     required this.eventDescription,
//     required this.eventDisclaimer,
//     required this.eventLatitude,
//     required this.eventLongtitude,
//     required this.eventProgress,
//     required this.eventPlaceName,
//     required this.eventFacilityId,
//     required this.eventRestictId,
//     required this.eventTags,
//     required this.eventVurls,
//     required this.totalTicket,
//     required this.totalBookTicket,
//     required this.gallerydata,
//     required this.artistdata,
//     required this.facilitydata,
//     required this.restrictiondata,
//     required this.joinedUser,
//     required this.attendUser,
//     required this.notjoinedUser,
//     required this.totalReview,
//   });

//   factory Eventdata.fromJson(Map<String, dynamic> json) => Eventdata(
//         eventId: json["event_id"],
//         eventTitle: json["event_title"],
//         eventCoverImg: json["event_cover_img"],
//         eventImage: json["event_image"],
//         eventStatus: json["event_status"],
//         eventStartDate: DateTime.parse(json["event_start_date"]),
//         eventStartTime: json["event_start_time"],
//         eventEndTime: json["event_end_time"],
//         eventAddress: json["event_address"],
//         eventDescription: json["event_description"],
//         eventDisclaimer: json["event_disclaimer"],
//         eventLatitude: json["event_latitude"],
//         eventLongtitude: json["event_longtitude"],
//         eventProgress: json["event_progress"],
//         eventPlaceName: json["event_place_name"],
//         eventFacilityId: json["event_facility_id"],
//         eventRestictId: json["event_restict_id"],
//         eventTags: json["event_tags"],
//         eventVurls: json["event_vurls"],
//         totalTicket: json["total_ticket"],
//         totalBookTicket: json["total_book_ticket"],
//         gallerydata: List<String>.from(json["gallerydata"].map((x) => x)),
//         artistdata: List<Artistdatum>.from(
//             json["artistdata"].map((x) => Artistdatum.fromJson(x))),
//         facilitydata: List<Facilitydatum>.from(
//             json["facilitydata"].map((x) => Facilitydatum.fromJson(x))),
//         restrictiondata: List<Restrictiondatum>.from(
//             json["restrictiondata"].map((x) => Restrictiondatum.fromJson(x))),
//         joinedUser: List<JoinedUser>.from(
//             json["joined_user"].map((x) => JoinedUser.fromJson(x))),
//         attendUser: List<dynamic>.from(json["attend_user"].map((x) => x)),
//         notjoinedUser: List<JoinedUser>.from(
//             json["notjoined_user"].map((x) => JoinedUser.fromJson(x))),
//         totalReview: List<TotalReview>.from(
//             json["total_review"].map((x) => TotalReview.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "event_id": eventId,
//         "event_title": eventTitle,
//         "event_cover_img": eventCoverImg,
//         "event_image": eventImage,
//         "event_status": eventStatus,
//         "event_start_date":
//             "${eventStartDate.year.toString().padLeft(4, '0')}-${eventStartDate.month.toString().padLeft(2, '0')}-${eventStartDate.day.toString().padLeft(2, '0')}",
//         "event_start_time": eventStartTime,
//         "event_end_time": eventEndTime,
//         "event_address": eventAddress,
//         "event_description": eventDescription,
//         "event_disclaimer": eventDisclaimer,
//         "event_latitude": eventLatitude,
//         "event_longtitude": eventLongtitude,
//         "event_progress": eventProgress,
//         "event_place_name": eventPlaceName,
//         "event_facility_id": eventFacilityId,
//         "event_restict_id": eventRestictId,
//         "event_tags": eventTags,
//         "event_vurls": eventVurls,
//         "total_ticket": totalTicket,
//         "total_book_ticket": totalBookTicket,
//         "gallerydata": List<dynamic>.from(gallerydata.map((x) => x)),
//         "artistdata": List<dynamic>.from(artistdata.map((x) => x.toJson())),
//         "facilitydata": List<dynamic>.from(facilitydata.map((x) => x.toJson())),
//         "restrictiondata":
//             List<dynamic>.from(restrictiondata.map((x) => x.toJson())),
//         "joined_user": List<dynamic>.from(joinedUser.map((x) => x.toJson())),
//         "attend_user": List<dynamic>.from(attendUser.map((x) => x)),
//         "notjoined_user":
//             List<dynamic>.from(notjoinedUser.map((x) => x.toJson())),
//         "total_review": List<dynamic>.from(totalReview.map((x) => x.toJson())),
//       };
// }

// class Artistdatum {
//   String artistImg;
//   String artistTitle;
//   String artistRole;

//   Artistdatum({
//     required this.artistImg,
//     required this.artistTitle,
//     required this.artistRole,
//   });

//   factory Artistdatum.fromJson(Map<String, dynamic> json) => Artistdatum(
//         artistImg: json["artist_img"],
//         artistTitle: json["artist_title"],
//         artistRole: json["artist_role"],
//       );

//   Map<String, dynamic> toJson() => {
//         "artist_img": artistImg,
//         "artist_title": artistTitle,
//         "artist_role": artistRole,
//       };
// }

// class Facilitydatum {
//   String facilityImg;
//   String facilityTitle;

//   Facilitydatum({
//     required this.facilityImg,
//     required this.facilityTitle,
//   });

//   factory Facilitydatum.fromJson(Map<String, dynamic> json) => Facilitydatum(
//         facilityImg: json["facility_img"],
//         facilityTitle: json["facility_title"],
//       );

//   Map<String, dynamic> toJson() => {
//         "facility_img": facilityImg,
//         "facility_title": facilityTitle,
//       };
// }

// class JoinedUser {
//   String userImg;
//   String customername;
//   String customermobile;
//   String totalTicketPurchase;
//   String totalType;

//   JoinedUser({
//     required this.userImg,
//     required this.customername,
//     required this.customermobile,
//     required this.totalTicketPurchase,
//     required this.totalType,
//   });

//   factory JoinedUser.fromJson(Map<String, dynamic> json) => JoinedUser(
//         userImg: json["user_img"],
//         customername: json["customername"],
//         customermobile: json["customermobile"],
//         totalTicketPurchase: json["Total_ticket_purchase"],
//         totalType: json["Total_type"],
//       );

//   Map<String, dynamic> toJson() => {
//         "user_img": userImg,
//         "customername": customername,
//         "customermobile": customermobile,
//         "Total_ticket_purchase": totalTicketPurchase,
//         "Total_type": totalType,
//       };
// }

// class Restrictiondatum {
//   String restrictionImg;
//   String restrictionTitle;

//   Restrictiondatum({
//     required this.restrictionImg,
//     required this.restrictionTitle,
//   });

//   factory Restrictiondatum.fromJson(Map<String, dynamic> json) =>
//       Restrictiondatum(
//         restrictionImg: json["restriction_img"],
//         restrictionTitle: json["restriction_title"],
//       );

//   Map<String, dynamic> toJson() => {
//         "restriction_img": restrictionImg,
//         "restriction_title": restrictionTitle,
//       };
// }

// class TotalReview {
//   String userImg;
//   String customername;
//   String rateNumber;
//   String rateText;

//   TotalReview({
//     required this.userImg,
//     required this.customername,
//     required this.rateNumber,
//     required this.rateText,
//   });

//   factory TotalReview.fromJson(Map<String, dynamic> json) => TotalReview(
//         userImg: json["user_img"],
//         customername: json["customername"],
//         rateNumber: json["rate_number"],
//         rateText: json["rate_text"],
//       );

//   Map<String, dynamic> toJson() => {
//         "user_img": userImg,
//         "customername": customername,
//         "rate_number": rateNumber,
//         "rate_text": rateText,
//       };
// }

// To parse this JSON data, do
//
//     final eventInfo = eventInfoFromJson(jsonString);

import 'dart:convert';

EventInfo eventInfoFromJson(String str) => EventInfo.fromJson(json.decode(str));

String eventInfoToJson(EventInfo data) => json.encode(data.toJson());

class EventInfo {
  Eventdata eventdata;
  String responseCode;
  String result;
  String responseMsg;

  EventInfo({
    required this.eventdata,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  factory EventInfo.fromJson(Map<String, dynamic> json) => EventInfo(
        eventdata: Eventdata.fromJson(json["Eventdata"]),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "Eventdata": eventdata.toJson(),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class Eventdata {
  String eventId;
  String eventTitle;
  String eventCoverImg;
  String eventImage;
  String eventStatus;
  DateTime eventStartDate;
  String eventStartTime;
  String eventEndTime;
  String eventAddress;
  String eventDescription;
  String eventDisclaimer;
  String eventLatitude;
  String eventLongtitude;
  String eventProgress;
  String eventPlaceName;
  String eventTypeList;
  String eventRevnue;
  String ticketPrice;
  String eventTags;
  String eventVurls;
  int totalTicket;
  int totalBookTicket;
  List<dynamic> gallerydata;
  List<Artistdatum> artistdata;
  List<Facilitydatum> facilitydata;
  List<Restrictiondatum> restrictiondata;
  List<JoinedUser> joinedUser;
  List<JoinedUser> attendUser;
  List<JoinedUser> notjoinedUser;
  List<TotalReview> totalReview;

  Eventdata({
    required this.eventId,
    required this.eventTitle,
    required this.eventCoverImg,
    required this.eventImage,
    required this.eventStatus,
    required this.eventStartDate,
    required this.eventStartTime,
    required this.eventEndTime,
    required this.eventAddress,
    required this.eventDescription,
    required this.eventDisclaimer,
    required this.eventLatitude,
    required this.eventLongtitude,
    required this.eventProgress,
    required this.eventPlaceName,
    required this.eventTypeList,
    required this.eventRevnue,
    required this.ticketPrice,
    required this.eventTags,
    required this.eventVurls,
    required this.totalTicket,
    required this.totalBookTicket,
    required this.gallerydata,
    required this.artistdata,
    required this.facilitydata,
    required this.restrictiondata,
    required this.joinedUser,
    required this.attendUser,
    required this.notjoinedUser,
    required this.totalReview,
  });

  factory Eventdata.fromJson(Map<String, dynamic> json) => Eventdata(
        eventId: json["event_id"],
        eventTitle: json["event_title"],
        eventCoverImg: json["event_cover_img"],
        eventImage: json["event_image"],
        eventStatus: json["event_status"],
        eventStartDate: DateTime.parse(json["event_start_date"]),
        eventStartTime: json["event_start_time"],
        eventEndTime: json["event_end_time"],
        eventAddress: json["event_address"],
        eventDescription: json["event_description"],
        eventDisclaimer: json["event_disclaimer"],
        eventLatitude: json["event_latitude"],
        eventLongtitude: json["event_longtitude"],
        eventProgress: json["event_progress"],
        eventPlaceName: json["event_place_name"],
        eventTypeList: json["event_type_list"].toString(),
        eventRevnue: json["event_revnue"].toString(),
        ticketPrice: json["ticket_price"],
        eventTags: json["event_tags"],
        eventVurls: json["event_vurls"].toString(),
        totalTicket: json["total_ticket"],
        totalBookTicket: json["total_book_ticket"],
        gallerydata: List<dynamic>.from(json["gallerydata"].map((x) => x)),
        artistdata: List<Artistdatum>.from(
            json["artistdata"].map((x) => Artistdatum.fromJson(x))),
        facilitydata: List<Facilitydatum>.from(
            json["facilitydata"].map((x) => Facilitydatum.fromJson(x))),
        restrictiondata: List<Restrictiondatum>.from(
            json["restrictiondata"].map((x) => Restrictiondatum.fromJson(x))),
        joinedUser: List<JoinedUser>.from(
            json["joined_user"].map((x) => JoinedUser.fromJson(x))),
        attendUser: List<JoinedUser>.from(
            json["attend_user"].map((x) => JoinedUser.fromJson(x))),
        notjoinedUser: List<JoinedUser>.from(
            json["notjoined_user"].map((x) => JoinedUser.fromJson(x))),
        totalReview: List<TotalReview>.from(
            json["total_review"].map((x) => TotalReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "event_id": eventId,
        "event_title": eventTitle,
        "event_cover_img": eventCoverImg,
        "event_image": eventImage,
        "event_status": eventStatus,
        "event_start_date":
            "${eventStartDate.year.toString().padLeft(4, '0')}-${eventStartDate.month.toString().padLeft(2, '0')}-${eventStartDate.day.toString().padLeft(2, '0')}",
        "event_start_time": eventStartTime,
        "event_end_time": eventEndTime,
        "event_address": eventAddress,
        "event_description": eventDescription,
        "event_disclaimer": eventDisclaimer,
        "event_latitude": eventLatitude,
        "event_longtitude": eventLongtitude,
        "event_progress": eventProgress,
        "event_place_name": eventPlaceName,
        "event_type_list": eventTypeList,
        "event_revnue": eventRevnue,
        "ticket_price": ticketPrice,
        "event_tags": eventTags,
        "event_vurls": eventVurls,
        "total_ticket": totalTicket,
        "total_book_ticket": totalBookTicket,
        "gallerydata": List<dynamic>.from(gallerydata.map((x) => x)),
        "artistdata": List<dynamic>.from(artistdata.map((x) => x.toJson())),
        "facilitydata": List<dynamic>.from(facilitydata.map((x) => x.toJson())),
        "restrictiondata":
            List<dynamic>.from(restrictiondata.map((x) => x.toJson())),
        "joined_user": List<dynamic>.from(joinedUser.map((x) => x.toJson())),
        "attend_user": List<dynamic>.from(attendUser.map((x) => x.toJson())),
        "notjoined_user":
            List<dynamic>.from(notjoinedUser.map((x) => x.toJson())),
        "total_review": List<dynamic>.from(totalReview.map((x) => x.toJson())),
      };
}

class Facilitydatum {
  String facilityImg;
  String facilityTitle;

  Facilitydatum({
    required this.facilityImg,
    required this.facilityTitle,
  });

  factory Facilitydatum.fromJson(Map<String, dynamic> json) => Facilitydatum(
        facilityImg: json["facility_img"],
        facilityTitle: json["facility_title"],
      );

  Map<String, dynamic> toJson() => {
        "facility_img": facilityImg,
        "facility_title": facilityTitle,
      };
}

class Artistdatum {
  String artistImg;
  String artistTitle;
  String artistRole;

  Artistdatum({
    required this.artistImg,
    required this.artistTitle,
    required this.artistRole,
  });

  factory Artistdatum.fromJson(Map<String, dynamic> json) => Artistdatum(
        artistImg: json["artist_img"],
        artistTitle: json["artist_title"],
        artistRole: json["artist_role"],
      );

  Map<String, dynamic> toJson() => {
        "artist_img": artistImg,
        "artist_title": artistTitle,
        "artist_role": artistRole,
      };
}

class JoinedUser {
  String userImg;
  String customername;
  String customermobile;
  String totalTicketPurchase;
  String totalType;

  JoinedUser({
    required this.userImg,
    required this.customername,
    required this.customermobile,
    required this.totalTicketPurchase,
    required this.totalType,
  });

  factory JoinedUser.fromJson(Map<String, dynamic> json) => JoinedUser(
        userImg: json["user_img"],
        customername: json["customername"],
        customermobile: json["customermobile"],
        totalTicketPurchase: json["Total_ticket_purchase"],
        totalType: json["Total_type"],
      );

  Map<String, dynamic> toJson() => {
        "user_img": userImg,
        "customername": customername,
        "customermobile": customermobile,
        "Total_ticket_purchase": totalTicketPurchase,
        "Total_type": totalType,
      };
}

class Restrictiondatum {
  String restrictionImg;
  String restrictionTitle;

  Restrictiondatum({
    required this.restrictionImg,
    required this.restrictionTitle,
  });

  factory Restrictiondatum.fromJson(Map<String, dynamic> json) =>
      Restrictiondatum(
        restrictionImg: json["restriction_img"],
        restrictionTitle: json["restriction_title"],
      );

  Map<String, dynamic> toJson() => {
        "restriction_img": restrictionImg,
        "restriction_title": restrictionTitle,
      };
}

class TotalReview {
  String userImg;
  String customername;
  String rateNumber;
  String rateText;

  TotalReview({
    required this.userImg,
    required this.customername,
    required this.rateNumber,
    required this.rateText,
  });

  factory TotalReview.fromJson(Map<String, dynamic> json) => TotalReview(
        userImg: json["user_img"],
        customername: json["customername"],
        rateNumber: json["rate_number"],
        rateText: json["rate_text"],
      );

  Map<String, dynamic> toJson() => {
        "user_img": userImg,
        "customername": customername,
        "rate_number": rateNumber,
        "rate_text": rateText,
      };
}
