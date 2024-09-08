library youtube_music_browse;
import 'package:youtube_music_browse/ytmusic/ytmusic.dart';
import 'models/section_model.dart';
export 'models/section_model.dart';

class YoutubeCharts {

  String? _continuation;
  bool _isFirst = true;
  Future<void> init() async {
    await _ytMusic.init();
    _isFirst = true;
  }
  late final YTMusic _ytMusic;
  static final YoutubeCharts _instance = YoutubeCharts._internal();

  factory YoutubeCharts() {
    return _instance;
  }
  YoutubeCharts._internal() {
    _ytMusic = YTMusic();
  }

  Future<List<Section>> getAllSections({String? continuation, bool isFirst = true}) async {
    final List<Section> sectionList = [];
    if(!isFirst && (continuation == null || continuation.isEmpty) ) {
      return sectionList;
    }
    else {
      List<dynamic> sectionsJson = [];
      Map<String, dynamic> browseResults = {};
      if(isFirst) {
        browseResults = await _ytMusic.browse();
      }
      else {
        browseResults = await _ytMusic.browse(additionalParams: continuation!);
      }
      sectionsJson = browseResults['sections'];

      for(final sectionJson in sectionsJson) {
        sectionList.add(Section.fromJson(sectionJson.cast<String, dynamic>()));
      }
      final newContinuation = browseResults['continuation'];
      return [...sectionList, ...(await getAllSections(continuation: newContinuation, isFirst: false))];
    }
  }

  Future<List<Section>> getNextSections() async {
    final List<Section> sectionList = [];
    Map<String, dynamic> browseResults = {};
    if(!_isFirst && _continuation == null) {
      return sectionList;
    }
    else {
      if(_isFirst) {
        browseResults = await _ytMusic.browse();
        _isFirst = false;
      }
      else {
        browseResults = await _ytMusic.browseContinuation(additionalParams: _continuation!);
      }
      _continuation = browseResults['continuation'];
      List<dynamic> sectionsJson = browseResults['sections'];
      for(final sectionJson in sectionsJson) {
        sectionList.add(Section.fromJson(sectionJson.cast<String, dynamic>()));
      }
      return sectionList;
    }
  }

  Future<List<Section>> browse({Map<String, dynamic>? trailingParams, int limit = 2, String additionalParams = ''}) async {
    final Map<String, dynamic> results = await _ytMusic.browse(body: trailingParams, limit: limit, additionalParams: additionalParams);
    final List<Section> sectionList = [];
    final List<dynamic> sectionsJson = results['sections'];
    for(final sectionJson in sectionsJson) {
      sectionList.add(Section.fromJson(sectionJson.cast<String, dynamic>()));
    }
    return sectionList;
  }
}