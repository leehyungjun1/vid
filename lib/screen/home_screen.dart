import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video/component/custom_video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: video == null ? renderEmpty() : renderVideo(),
    );
  }

  Widget renderEmpty() {
    // ➌ 동영상 선택 전 보여줄 위젯
    return Container(
      width: MediaQuery.of(context).size.width, // 넓이 최대로 늘려주기
      decoration: getBoxDecoration(),
      child: Column(
        // 위젯들 가운데 정렬
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onTap: onNewVideoPressed,
          ),
          const SizedBox(height: 30.0),
          const _AppName(), // 앱 이름
        ],
      ),
    );
  }

  void onNewVideoPressed() async {
    // ➋ 이미지 선택하는 기능을 구현한 함수
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }

  BoxDecoration getBoxDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2A3A7C),
          Color(0XFF000118),
        ],
      ),
    );
  }

  Widget renderVideo() {
    return Center(
      child: CustomVideoPlayer(
        video: video!, // ➋ 선택된 동영상 입력해주기
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final GestureTapCallback onTap;

  const _Logo({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        'asset/img/logo.png',
      ),
    );
  }
}

class _AppName extends StatelessWidget {
  const _AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          style: textStyle.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
