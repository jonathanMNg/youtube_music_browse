import 'package:flutter/material.dart';
import 'package:youtube_charts/youtube_charts.dart';
import 'dart:convert';
import 'dart:developer';

pprint(data) {
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  final jsonString = encoder.convert(data);
  log(jsonString);
}
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final ytCharts = YoutubeCharts();
  // await ytCharts.init();
  // final firstSections = await ytCharts.getAllSections();
  // for(final section in firstSections) {
  //   if(section.title != null) {
  //     print('${section.title} ${section.viewType} ${section.trailing?.endpoint}');
  //     if( !(section.trailing?.playable??false) && section.trailing?.endpoint != null) {
  //       final newSections = await ytCharts.browse(body: section.trailing!.endpoint, limit: 2);
  //       print(newSections.length);
  //       // print('newSections ${newSections.length}');
  //       // for(final section1 in newSections) {
  //       //   print('section1: ${section1.title}');
  //       // }
  //     }
  //     // for(final content in section.contents!) {
  //     //   pprint('content title: ${content.title} | type: ${content.type} | id: ${content.videoId} | playlistId: ${content.playlistId}');
  //     // }
  //   }
  //   // else {
  //   //   print(section.contents?.length);
  //   // }
  // }
  final result = await ytCharts.browse(trailingParams: {
    "browseId": "FEmusic_new_releases_albums"
  });
  for(final section in result) {
    print('Section: ${section.title}');
    if(section.viewType == ViewType.singleColumn) {
      final contents = section.contents;
      print('Length: ${contents?.length}');
    }
  }
  // final nextSections = await ytCharts.getNextSections();
  // for(final section in nextSections) {
  //   if(section.title != null) {
  //     print(section.title);
  //     // if(section.contents!= null) {
  //     //   for(final content in section.contents!) {
  //     //     print('content title: ${content.title} | type: ${content.type} | id: ${content.videoId} | playlistId: ${content.playlistId}');
  //     //   }
  //     // }
  //   }
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Container(),
    );
  }
}
