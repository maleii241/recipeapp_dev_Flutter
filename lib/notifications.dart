import 'package:flutter/material.dart';
import 'package:flutter_smart_home_ui/screens/video_screen.dart';
import 'package:flutter_smart_home_ui/services/api_service.dart';
import 'package:kf_drawer/kf_drawer.dart';

import 'constants.dart';
import 'models/channel_model.dart';
import 'models/video_model.dart';

class Notifications extends KFDrawerContent {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  Channel _channel;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _initChannel();
  }
  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UC3KKTJ-z5RmBqNtleRBl7fQ');
    setState(() {
      _channel = channel;
    });
  }

  _buildProfileInfo() {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      height: 100.0,
      decoration: BoxDecoration(
       // color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            //blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
          //  backgroundColor: Colors.white,
            radius: 35.0,
            backgroundImage: NetworkImage(_channel.profilePictureUrl),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _channel.title,
                  style: TextStyle(
                    //color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(id: video.id),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        height: 140.0,
        decoration: BoxDecoration(
          color: Colors.green,
          boxShadow: [
            BoxShadow(
              //color: Colors.black12,

              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Image(
              width: 150.0,
              image: NetworkImage(video.thumbnailUrl),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                video.title,
                style: TextStyle(
                  //color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel.uploadPlaylistId);
    List<Video> allVideos = _channel.videos..addAll(moreVideos);
    setState(() {
      _channel.videos = allVideos;
    });
    _isLoading = false;
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text('Видео'),

        actions: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(36.0)),
                child: Material(
                  shadowColor: kPrimaryColor,
                  color: kPrimaryColor,
                  child: IconButton(
                    icon: Icon(Icons.home, color: Colors.white),
                    onPressed: widget.onMenuPressed,
                  ),
                ),
              ),
            ],
          ),
        ],

      ),
      body: _channel != null
          ? NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollDetails) {
          if (!_isLoading &&
              _channel.videos.length != int.parse(_channel.videoCount) &&
              scrollDetails.metrics.pixels ==
                  scrollDetails.metrics.maxScrollExtent) {
            _loadMoreVideos();
          }
          return false;
        },
        child: ListView.builder(
          itemCount: 1 + _channel.videos.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return _buildProfileInfo();
            }
            Video video = _channel.videos[index - 1];
            return _buildVideo(video);
          },
        ),
      )
          : Center(

        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor,
          ),
        ),



      ),
    );
  }
}