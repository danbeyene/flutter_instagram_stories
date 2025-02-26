import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_stories/video_player_card.dart';
import 'components//stories_list_skeleton.dart';
import 'grouped_stories_view.dart';
import 'models/stories.dart';
import 'models/stories_data.dart';
import 'models/stories_list_with_pressed.dart';

export 'grouped_stories_view.dart';

Future<void> showStories({
  required BuildContext context,
  required String collectionDbName,
  String languageCode = 'en',
  int imageStoryDuration = 5,
  ProgressPosition progressPosition = ProgressPosition.top,
  bool repeat = true,
  bool inline=false,
  Color backgroundColorBetweenStories = Colors.black,
  Icon? closeButtonIcon,
  Color? closeButtonBackgroundColor,
  bool sortingOrderDesc = true,
  TextStyle captionTextStyle = const TextStyle(
    fontSize: 15,
    color: Colors.white,
  ),
  EdgeInsets captionPadding = const EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 8,
  ),
  EdgeInsets captionMargin = const EdgeInsets.only(
    bottom: 24,
  ),

}) async {

  StoriesData _storiesData = StoriesData(languageCode: languageCode);
   List<QueryDocumentSnapshot>? stories;
  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
      .collection(collectionDbName)
      .orderBy('date', descending: sortingOrderDesc).get();
  if(snapshot.docs.isNotEmpty){
    stories = snapshot.docs;
    final List<Stories> storyWidgets =
    _storiesData.parseStoriesPreview(stories);
    Stories story = storyWidgets[0];
    // the variable below is for passing stories ids to screen Stories
    final List<String> storiesIdsList = _storiesData.storiesIdsList;


    Navigator.push(
      context,
      NoAnimationMaterialPageRoute(
        builder: (context) => GroupedStoriesView(
          collectionDbName: collectionDbName,
          languageCode: languageCode,
          imageStoryDuration: imageStoryDuration,
          progressPosition: progressPosition,
          repeat: repeat,
          inline: inline,
          backgroundColorBetweenStories: backgroundColorBetweenStories,
          closeButtonIcon: closeButtonIcon,
          closeButtonBackgroundColor: closeButtonBackgroundColor,
          sortingOrderDesc: sortingOrderDesc,
          captionTextStyle: captionTextStyle,
          captionPadding: captionPadding,
          captionMargin: captionMargin,
        ),
        settings: RouteSettings(
          arguments: StoriesListWithPressed(
              pressedStoryId: story.storyId, storiesIdsList: storiesIdsList),
        ),
      ),
//                        ModalRoute.withName('/'),
    );
  }
}

class FlutterInstagramStories extends StatefulWidget {
  /// the name of the collection in Firestore, more info here https://github.com/awaik/flutter_instagram_stories
  final String collectionDbName;
  final String languageCode;

  /// highlight last icon (story image preview)
  final bool lastIconHighlight;
  final Color lastIconHighlightColor;
  final Radius lastIconHighlightRadius;

  /// preview images settings
  final double? iconWidth;
  final double? iconHeight;
  final bool showTitleOnIcon;
  final TextStyle? iconTextStyle;
  final BoxDecoration? iconBoxDecoration;
  final BorderRadiusGeometry? iconImageBorderRadius;
  final EdgeInsets textInIconPadding;

  /// caption on image
  final TextStyle captionTextStyle;
  final EdgeInsets captionMargin;
  final EdgeInsets captionPadding;

  /// how long story lasts
  final int imageStoryDuration;

  /// background color between stories
  final Color backgroundColorBetweenStories;

  /// stories close button style
  final Icon? closeButtonIcon;
  final Color? closeButtonBackgroundColor;

  /// stories sorting order Descending
  final bool sortingOrderDesc;

  /// callback to get data that stories screen was opened
  final VoidCallback? backFromStories;

  final ProgressPosition progressPosition;
  final bool repeat;
  final bool inline;
  final bool isDarkMode;

  FlutterInstagramStories(
      {required this.collectionDbName,
      this.lastIconHighlight = false,
      this.lastIconHighlightColor = Colors.deepOrange,
      this.lastIconHighlightRadius = const Radius.circular(15.0),
      this.iconWidth,
      this.iconHeight,
      this.showTitleOnIcon = true,
      this.iconTextStyle,
      this.iconBoxDecoration,
      this.iconImageBorderRadius,
      this.textInIconPadding =
          const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      this.captionTextStyle = const TextStyle(
        fontSize: 15,
        color: Colors.white,
      ),
      this.captionMargin = const EdgeInsets.only(
        bottom: 24,
      ),
      this.captionPadding = const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 8,
      ),
      this.imageStoryDuration = 5,
      this.backgroundColorBetweenStories = Colors.black,
      this.closeButtonIcon,
      this.closeButtonBackgroundColor,
      this.sortingOrderDesc = true,
      this.backFromStories,
      this.progressPosition = ProgressPosition.top,
      this.repeat = true,
      this.inline = false,
        required this.isDarkMode,
      this.languageCode = 'en'});

  @override
  _FlutterInstagramStoriesState createState() =>
      _FlutterInstagramStoriesState();
}

class _FlutterInstagramStoriesState extends State<FlutterInstagramStories> {
  late StoriesData _storiesData;
  // final _firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot<Map<String, dynamic>>> snapshotStream;
  bool _backStateAdditional = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    snapshotStream = FirebaseFirestore.instance
        .collection(widget.collectionDbName)
        .orderBy('date', descending: widget.sortingOrderDesc)
        .snapshots();
    _storiesData = StoriesData(languageCode: widget.languageCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? res = ModalRoute.of(context)!.settings.arguments as String?;
    return Container(
      color: Colors.transparent,
      height: widget.iconHeight! + 24,
      child: StreamBuilder<QuerySnapshot>(
        stream: snapshotStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              primary: false,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 8.0, bottom: 16.0),
                  child: InkWell(
                    child: Container(
                      width: widget.iconWidth,
                      height: widget.iconHeight,
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: widget.iconImageBorderRadius ??
                                BorderRadius.zero,
                            child: StoriesListSkeletonAlone(
                              width: widget.iconWidth!,
                              height: widget.iconHeight!,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          List<QueryDocumentSnapshot> stories = snapshot.data!.docs;

          final List<Stories> storyWidgets =
              _storiesData.parseStoriesPreview(stories);

          // the variable below is for passing stories ids to screen Stories
          final List<String> storiesIdsList = _storiesData.storiesIdsList;

          _buildFuture(res);

          return ListView.builder(
            padding: EdgeInsets.only(right: 15.0),
            scrollDirection: Axis.horizontal,
            primary: false,
            itemCount: stories.length,
            itemBuilder: (BuildContext context, int index) {
              Stories story = storyWidgets[index];
              // print(
              //     "this is all stories ========================================= ${story.toString()}");
              story.previewTitle?.putIfAbsent(widget.languageCode, () => '');

              return Padding(
                padding: EdgeInsets.only(left: 15.0, top: 8.0, bottom: 16.0),
                child: InkWell(
                  child: Container(
                    decoration: widget.iconBoxDecoration,
                    width: widget.iconWidth,
                    height: widget.iconHeight,
                    child: Stack(children: <Widget>[
                      ClipRRect(
                        borderRadius:
                        widget.iconImageBorderRadius ?? BorderRadius.zero,
                        child: story.file![0].filetype == 'image'?CachedNetworkImage(
                          imageUrl: story.file![0].url![widget.languageCode]!,
                          width: widget.iconWidth,
                          height: widget.iconHeight,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              StoriesListSkeletonAlone(
                                width: widget.iconWidth!,
                                height: widget.iconHeight!,
                              ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ):VideoPlayerCard(videoUrl: story.file![0].url![widget.languageCode]!, width: widget.iconWidth!, height: widget.iconHeight!,isDarkMode: widget.isDarkMode,),
                      ),
                      Container(
                        width: widget.iconWidth,
                        height: widget.iconHeight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                              padding: widget.textInIconPadding,
                              child: Text(
                                story.previewTitle?[widget.languageCode] ?? '',
                                style: widget.iconTextStyle,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  onTap: () async {
                    _backStateAdditional = true;
                    Navigator.push(
                      context,
                      NoAnimationMaterialPageRoute(
                        builder: (context) => GroupedStoriesView(
                          collectionDbName: widget.collectionDbName,
                          languageCode: widget.languageCode,
                          imageStoryDuration: widget.imageStoryDuration,
                          progressPosition: widget.progressPosition,
                          repeat: widget.repeat,
                          inline: widget.inline,
                          backgroundColorBetweenStories:
                          widget.backgroundColorBetweenStories,
                          closeButtonIcon: widget.closeButtonIcon,
                          closeButtonBackgroundColor:
                          widget.closeButtonBackgroundColor,
                          sortingOrderDesc: widget.sortingOrderDesc,
                          captionTextStyle: widget.captionTextStyle,
                          captionPadding: widget.captionPadding,
                          captionMargin: widget.captionMargin,
                        ),
                        settings: RouteSettings(
                          arguments: StoriesListWithPressed(
                              pressedStoryId: story.storyId,
                              storiesIdsList: storiesIdsList),
                        ),
                      ),
//                        ModalRoute.withName('/'),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  _buildFuture(String? res) async {
    await Future.delayed(const Duration(seconds: 1));
    if (res == 'back_from_stories_view' && !_backStateAdditional) {
      widget.backFromStories!();
    }
  }
}
