import 'package:flutter/material.dart';
import 'package:youtube_music_browse/youtube_music_browse.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:youtube_music_browse/ytmusic/ytmusic.dart';

pprint(data) {
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  final jsonString = encoder.convert(data);
  log(jsonString);
}
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final ytCharts = YoutubeCharts();
  await ytCharts.init();
  // final data = await ytMusic.search('In the end');
  // pprint(data);
  // pprint(await ytCharts.getSearchSuggestions('In th'));
  // final sections = await ytCharts.search('In the end');

  // await ytCharts.init();
  // final firstSections = await ytCharts.getAllSections();
  // for(final section in sections) {
  //
  //   print('${section.title} ${section.trailing?.endpoint}');
    // if( !(section.trailing?.playable??false) && section.trailing?.endpoint != null) {
    //   final newSections = await ytCharts.browse(trailingParams: section.trailing!.endpoint, limit: 2);
    //   print(newSections.length);
      // print('newSections ${newSections.length}');
      // for(final section1 in newSections) {
      //   print('section1: ${section1.title}');
      // }
    // }
    // for(final content in section.contents!) {
    //   pprint('content title: ${content.title} | type: ${content.type} | id: ${content.videoId} | playlistId: ${content.playlistId}');
    // }
    // else {
    //   print(section.contents?.length);
    // }
  // }
  final result = await ytCharts.browse(trailingParams: {
    "browseId": "UCxgN32UVVztKAQd2HkXzBtw",
    "browseEndpointContextSupportedConfigs": {
      "browseEndpointContextMusicConfig": {
        "pageType": "MUSIC_PAGE_TYPE_ARTIST"
      }
    }
  });
  for(final section in result) {
    print('Section: ${section.title}');
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




