import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network('https://via.placeholder.com/50', fit: BoxFit.cover), // Placeholder para o logotipo
        ),
        title: Text(
          'Alunos',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Olá, pessoa', style: TextStyle(color: Colors.black)),
                SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
      body: VideoCards(),
    );
  }
}

class VideoCards extends StatefulWidget {
  @override
  _VideoCardsState createState() => _VideoCardsState();
}

class _VideoCardsState extends State<VideoCards> {
  List<bool> _isExpanded = List.generate(5, (index) => false);

String DateNow() {
  DateTime now = DateTime.now();
  String formattedDate = '${now.day}/${now.month}/${now.year}';
  return formattedDate; // Exemplo de saída: 02/03/2021
}


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _isExpanded.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.pink[100],
          margin: EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  //Defnir o Nome dos alunos e a data daquele dia
                  'Aluno ${index + 1} - ${DateNow()}',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.check_circle_outline, color: Colors.black),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Aprovado!')),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline, color: Colors.black),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Reprovado!')),
                        );
                      },
                    ),
                  ],
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          //Defirir o Tipo do desafio referente ao dia
                          child: Text('Desafio - Tal', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                        ),
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

  //Definir o video de acordo com o index do aluno - Puxar da base de dados
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
