import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'component/artist_row.dart';
import 'component/header.dart';
import 'component/image_container.dart';

String url1 = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';
String url2 = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3 ';
String url3 = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'audio player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AudioPlayers(),
    );
  }
}

class AudioPlayers extends StatefulWidget {
  const AudioPlayers({Key? key}) : super(key: key);

  @override
  State<AudioPlayers> createState() => _AudioPlayersState();
}

class _AudioPlayersState extends State<AudioPlayers> {
  final urlList = <String>[
    url1,
    url2,
    url3,
  ];
  int index = 0;
  late String defaultUrl;
  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = false;

  @override
  void initState() {
    defaultUrl = urlList[index];
    setAudio();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF181424),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderRow(),
              const SizedBox(height: 16),
              const ImageContainer(),
              const SizedBox(height: 40),
              const ArtistRow(),
              const SizedBox(height: 5),
              const Text("Akonda",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(
                height: 15,
              ),
              buildSlider(),
              const SizedBox(height: 10),
              playerButton(size),
              Spacer(),

              //Bottom sheet
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Episode',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    GestureDetector(
                        onTap: bottomSheet,
                        child: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 40,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: const Color(0xFF181424),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              buildListTile(
                "assets/images/leadingimg.jpg",
                Icons.play_arrow,
              ),
              buildListTile(
                "assets/images/leadingimg.jpg",
                Icons.play_arrow,
              ),
              buildListTile(
                "assets/images/lockleadingimg.jpg",
                Icons.lock,
              ),
              buildListTile(
                "assets/images/lockleadingimg.jpg",
                Icons.lock,
              ),
              buildListTile(
                "assets/images/lockleadingimg.jpg",
                Icons.lock,
              ),
              buildListTile(
                "assets/images/lockleadingimg.jpg",
                Icons.lock,
              ),
              buildListTile(
                "assets/images/lockleadingimg.jpg",
                Icons.lock,
              ),
              buildListTile(
                "assets/images/lockleadingimg.jpg",
                Icons.lock,
              ),
            ],
          ),
        );
      },
    );
  }

  ListTile buildListTile(String url, IconData iconData) {
    return ListTile(
      leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          child: Image.asset(url)),
      title: const Text(
        "Episode Name Here",
        style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            wordSpacing: 2),
      ),
      subtitle: const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text("Writer : Ishtiaqe Ahmed",
            style:
                TextStyle(color: Colors.grey, fontSize: 17, letterSpacing: 1)),
      ),
      trailing: iconData == Icons.lock
          ? Icon(
            iconData,
            color: Colors.grey,
            size: 30,
          )
          : CircleAvatar(
              backgroundColor: Colors.white,
              radius: 14,
              child: Center(
                child: Icon(
                  iconData,
                  color: Colors.black,
                ),
              ),
            ),
    );
  }

  Widget buildSlider() {
    return Slider.adaptive(
      inactiveColor: Colors.black,
      activeColor: Colors.grey,
      thumbColor: Colors.white,
      min: 0,
      max: duration.inSeconds.toDouble(),
      value: position.inSeconds.toDouble(),
      onChanged: (value) async {
        final position = Duration(seconds: value.toInt());
        await audioPlayer.seek(position);
        await audioPlayer.resume();
      },
    );
  }

  Padding playerButton(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width / 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.shuffle,
            size: 30,
            color: Colors.grey,
          ),
          IconButton(
              onPressed: () async {
                setState(() {
                  if (index == 0) {
                    index = 0;
                  } else {
                    index = index - 1;
                  }
                  defaultUrl = urlList[index];
                });
                await setAudio();
              },
              iconSize: 50,
              icon: Icon(
                Icons.skip_previous,
                color: Colors.white,
              )),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35,
            child: IconButton(
                onPressed: () async {
                  if (isPlaying) {
                    await audioPlayer.pause();
                  } else {
                    await audioPlayer.resume();
                  }
                },
                iconSize: 50,
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.black,
                )),
          ),
          IconButton(
              onPressed: () async {
                setState(() {
                  if (index == urlList.length - 1) {
                    index = urlList.length - 1;
                  } else {
                    index = index + 1;
                  }
                  defaultUrl = urlList[index];
                });
                await setAudio();
              },
              iconSize: 50,
              icon: Icon(
                Icons.skip_next,
                color: Colors.white,
              )),
          Icon(
            Icons.compare_arrows,
            size: 30,
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    audioPlayer.setSourceUrl(defaultUrl);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
