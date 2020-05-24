// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:league/Json/JsonData.dart';
// import 'dart:convert';

//   Map<String, dynamic> summonerInfo = new Map<String, dynamic>();
//   Map<String, dynamic> summonerMatchHistory = new Map<String, dynamic>();
//   Map<String, dynamic> matchInfo = new Map<String, dynamic>();

//   Future<Map<String, dynamic>> searchForSummoner() async {
//     var summonerName = summonerNameController.text.replaceAll(" ", "%20");
//     var preparedURL = "https://" + regionsMap[selectedRegion] + ".api.riotgames.com/lol/summoner/v4/summoners/by-name/" + summonerName + "?api_key=" + JsonData.apiKey;
//     var jsonResponse = await http.get(preparedURL);
//     if (jsonResponse.statusCode != 200) {
//       throw Exception('Failed to make connection with api');
//     } else {
//       summonerInfo = jsonDecode(utf8.decode(jsonResponse.bodyBytes));
//       preparedURL = 'https://' + regionsMap[selectedRegion] + '.api.riotgames.com/lol/match/v4/matchlists/by-account/' + summonerInfo["accountId"] + '?api_key=' + JsonData.apiKey;
//       jsonResponse = await http.get(preparedURL);
//       if (jsonResponse.statusCode != 200) {
//         throw Exception('Failed to make connection with api');
//       } else {
//         var champions = JsonData.allChampionsInfo;
//         summonerMatchHistory = jsonDecode(utf8.decode(jsonResponse.bodyBytes));
//       }
//     }
    
//     Map<String, dynamic> jsonMap = new Map<String, dynamic>();
//     var preparedURLMatch = "https://" + regionsMap[selectedRegion] + ".api.riotgames.com/lol/match/v4/matches/" + gameID + "?api_key=" +JsonData.apiKey;
//     var jsonResponseMatch = await http.get(preparedURLMatch);
    
//     if (jsonResponseMatch.statusCode != 200) {
//       throw Exception('Failed to make connection with api');
//     } else {
//       return jsonDecode(utf8.decode(jsonResponseMatch.bodyBytes));
//     }
//   }
