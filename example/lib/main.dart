import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_instagram_stories/flutter_instagram_stories.dart';

import 'firebase_options.dart';
import 'style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        //TODO: implement dark mode switcher and adapt plugin for dark mode
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        home: const Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static String collectionDbName =
      'users/otHWpufd7s8PVJaa0mUr/instagram_stories_db';

  //TODO: add possibility get data from any API
  CollectionReference dbInstance = FirebaseFirestore.instance
      .collection('users')
      .doc('otHWpufd7s8PVJaa0mUr')
      .collection(collectionDbName);

  List dataToBeUploaded = [
    {
      "date": DateTime.now(),
      "file": [
        {
          "fileTitle": {"en": "Next group story caption"},
          "fileType": "image",
          "url": {
            "en":
                "https://a0.muscache.com/im/pictures/miso/Hosting-892636584500492829/original/828bf472-0ba4-48d4-8f6b-b7b6e64c5ece.jpeg?im_w=720"
          }
        },
        {
          "fileTitle": {"en": "video caption"},
          "fileType": "video",
          "url": {
            "en":
                "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_10mb.mp4"
          }
        },
        {
          "fileType": "video",
          "url": {
            "en":
                "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4"
          }
        },
        {
          "fileTitle": {"en": "image caption 2"},
          "fileType": "image",
          "url": {
            "en":
                "https://a0.muscache.com/im/pictures/miso/Hosting-892636584500492829/original/846638fb-8833-4b0f-955d-ec3bbf1514ef.jpeg?im_w=720"
          }
        }
      ],
      "previewImage":
          "https://a0.muscache.com/im/pictures/miso/Hosting-892636584500492829/original/c45bf8cf-2ad6-4930-8c9f-f6f3c992aedd.jpeg?im_w=1200",
      "previewTitle": {"en": "Such a beauty 1"}
    },
    {
      "date": DateTime.now(),
      "file": [
        {
          "fileTitle": {"en": "Next group story caption"},
          "fileType": "image",
          "url": {
            "en":
                "https://a0.muscache.com/im/pictures/miso/Hosting-892636584500492829/original/828bf472-0ba4-48d4-8f6b-b7b6e64c5ece.jpeg?im_w=720"
          }
        },
        {
          "fileTitle": {"en": "video caption"},
          "fileType": "video",
          "url": {
            "en":
                "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_10mb.mp4"
          }
        },
        {
          "fileType": "video",
          "url": {
            "en":
                "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4"
          }
        },
        {
          "fileTitle": {"en": "image caption 2"},
          "fileType": "image",
          "url": {
            "en":
                "https://a0.muscache.com/im/pictures/miso/Hosting-892636584500492829/original/846638fb-8833-4b0f-955d-ec3bbf1514ef.jpeg?im_w=720"
          }
        }
      ],
      "previewImage":
          "https://a0.muscache.com/im/pictures/miso/Hosting-721540609203378406/original/9dfaf7d6-40f2-4673-b468-7c5ab3147f86.jpeg?im_w=1200",
      "previewTitle": {"en": "Such a beauty 2"}
    },
    {
      "date": DateTime.now(),
      "file": [
        {
          "fileTitle": {"en": "Next group story caption"},
          "fileType": "image",
          "url": {
            "en":
                "https://a0.muscache.com/im/pictures/miso/Hosting-892636584500492829/original/828bf472-0ba4-48d4-8f6b-b7b6e64c5ece.jpeg?im_w=720"
          }
        },
        {
          "fileTitle": {"en": "video caption"},
          "fileType": "video",
          "url": {
            "en":
                "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_10mb.mp4"
          }
        },
        {
          "fileType": "video",
          "url": {
            "en":
                "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4"
          }
        },
        {
          "fileTitle": {"en": "image caption 2"},
          "fileType": "image",
          "url": {
            "en":
                "https://a0.muscache.com/im/pictures/miso/Hosting-892636584500492829/original/846638fb-8833-4b0f-955d-ec3bbf1514ef.jpeg?im_w=720"
          }
        }
      ],
      "previewImage":
          "https://a0.muscache.com/im/pictures/miso/Hosting-826134718441577316/original/da0692f3-d54d-4af4-a35e-75e2f6aee135.jpeg?im_w=1200",
      "previewTitle": {"en": "Such a beauty 3"}
    }
  ];

  @override
  void initState() {
    super.initState();
    // updateData();
  }

  Future<void> updateData() async {
    for (var data in dataToBeUploaded) {
      await dbInstance.add(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter instagram stories"),
      ),
      body: Container(
        color: Colors.indigo,
        child: Column(
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  await showStories(
                    context: context,
                    collectionDbName: collectionDbName,
                    languageCode: 'en',
                    imageStoryDuration: 7,
                    progressPosition: ProgressPosition.top,
                    repeat: false,
                    inline: false,
                    backgroundColorBetweenStories: Colors.black,
                    closeButtonIcon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 28.0,
                    ),
                    closeButtonBackgroundColor: const Color(0x11000000),
                    sortingOrderDesc: true,
                    captionTextStyle: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                    captionMargin: const EdgeInsets.only(
                      bottom: 50,
                    ),
                    captionPadding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                  );
                },
                child: const Text(
                  "Test Button",
                  style: TextStyle(color: Colors.blue),
                )),
            // FlutterInstagramStories(
            //   collectionDbName: collectionDbName,
            //   showTitleOnIcon: true,
            //   backFromStories: () {
            //     // _backFromStoriesAlert();
            //   },
            //   iconTextStyle: const TextStyle(
            //     fontSize: 14.0,
            //     color: Colors.white,
            //   ),
            //   iconImageBorderRadius: BorderRadius.circular(15.0),
            //   iconBoxDecoration: const BoxDecoration(
            //     borderRadius: BorderRadius.all(Radius.circular(15.0)),
            //     color: Color(0xFFffffff),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Color(0xff333333),
            //         blurRadius: 10.0,
            //         offset: Offset(
            //           0.0,
            //           4.0,
            //         ),
            //       ),
            //     ],
            //   ),
            //   iconWidth: 150.0,
            //   iconHeight: 150.0,
            //   textInIconPadding:
            //       const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0),
            //   //how long story lasts in seconds
            //   imageStoryDuration: 7,
            //   progressPosition: ProgressPosition.top,
            //   repeat: false,
            //   inline: false,
            //   languageCode: 'en',
            //   backgroundColorBetweenStories: Colors.black,
            //   closeButtonIcon: const Icon(
            //     Icons.close,
            //     color: Colors.white,
            //     size: 28.0,
            //   ),
            //   closeButtonBackgroundColor: const Color(0x11000000),
            //   sortingOrderDesc: true,
            //   lastIconHighlight: true,
            //   lastIconHighlightColor: Colors.deepOrange,
            //   lastIconHighlightRadius: const Radius.circular(15.0),
            //   captionTextStyle: const TextStyle(
            //     fontSize: 22,
            //     color: Colors.white,
            //   ),
            //   captionMargin: const EdgeInsets.only(
            //     bottom: 50,
            //   ),
            //   captionPadding: const EdgeInsets.symmetric(
            //     horizontal: 24,
            //     vertical: 8,
            //   ), isDarkMode: true,
            // ),
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "App's functionality",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _backFromStoriesAlert() {
    showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: const Text(
          "User have looked stories and closed them.",
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0),
        ),
        children: <Widget>[
          SimpleDialogOption(
            child: const Text("Dismiss"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
