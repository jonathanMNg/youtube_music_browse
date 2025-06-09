library ytmusic;

import 'package:youtube_music_browse/ytmusic/mixins/search.dart';

import 'mixins/browsing.dart';
import 'yt_service_provider.dart';

class YTMusic extends YTMusicServices
    with BrowsingMixin, SearchMixin {}
