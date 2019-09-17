import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:structured_notes/util/Theme.dart';
import 'package:youtube_player/youtube_player.dart';
import '../model/VideoData.dart';

class VideoPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        elevation: 0,
        backgroundColor: white,
        title: AutoSizeText(
          'Market Linked GICs',
          textAlign: TextAlign.center,
          maxLines: 1,
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        //Text(),
        centerTitle: true,
      ),
      body: VideoPageBody(),
    );
  }
}

class VideoPageBody extends StatefulWidget {
  @override
  _VideoPageBodyState createState() => _VideoPageBodyState();
}

class _VideoPageBodyState extends State<VideoPageBody> {
  List<VideoData> _dataList = new List();


  @override
  void initState() {
    super.initState();
    _dataList = getDummyVideoList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
          child: Column(
            children: <Widget>[
              YoutubePlayer(
                context: context,
                width: MediaQuery.of(context).size.width-8,
                source: _dataList[index].videoId,
                quality: YoutubeQuality.HD,
                controlsActiveBackgroundOverlay: true,
                showThumbnail: false,
                hideShareButton: true,
                playerMode: YoutubePlayerMode.DEFAULT,
                reactToOrientationChange: false,
                showVideoProgressbar: false,
                autoPlay: false,
              ),

              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      _dataList[index].title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(_dataList[index].description,textAlign: TextAlign.center,),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      itemCount: _dataList.length,
    );
  }

  List<VideoData> getDummyVideoList() {
    return List.of(
      [
        VideoData(
            videoId: "aqz-KE-bpKQ",
            title: "Income with Quaterly Payments",
            description: "This MLGIC may be suitable for inverstors"
                " who value principle protection, required quaterly cash flow, and are seeking the potentialfor enhanced yield relative to their"
                " fixed-rate GICs"),
        VideoData(
            videoId: "nPt8bK2gbaU",
            title: "Income with Quaterly Payments",
            description: "This MLGIC may be suitable for inverstors"
                " who value principle protection, required quaterly cash flow, and are seeking the potentialfor enhanced yield relative to their"
                " fixed-rate GICs"),
      ],
    );
  }
}
