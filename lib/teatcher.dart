import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override


  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Alunos'),
        ),
        body: VideoCards(),
      ),
    );
  }
}

class VideoCards extends StatefulWidget {
  @override
  _VideoCardsState createState() => _VideoCardsState();
}

class _VideoCardsState extends State<VideoCards> {
  List<bool> _isExpanded = List.generate(5, (index) => false);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _isExpanded.length,
      itemBuilder: (context, index) {
        return Card( color: Color.fromARGB(100, 255, 17, 0) ,
          child: Column(
            children: [
              ListTile(
                title: Text('Aluno $index'),
                trailing: Icon(
                  _isExpanded[index] ? Icons.expand_less : Icons.expand_more,
                ),
                onTap: () {
                  setState(() {
                    _isExpanded[index] = !_isExpanded[index];
                  });
                },
              ),
              _isExpanded[index]
                  ? Column(
                      children: [
                        Container(
                          height: 200,
                          child: VideoWidget(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Aprovado!')),
                                );
                              },
                              child: Text('Aprovado'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Reprovado!')),
                                );
                              },
                              child: Text('Reprovado'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}

class VideoWidget extends StatefulWidget {
  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: false,
      looping: false,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController!,
    );
  }
}
