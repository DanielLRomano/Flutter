import 'package:exemplo_audio_player/screens/audio_player_screen.dart';
import 'package:exemplo_audio_player/services/audio_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AudioServices _service = AudioServices();

  Future<void> _getAudioList() async {
    try {
      await _service.fetchAudio();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Audio Player'), actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _getAudioList();
              })
        ]),
        body: Padding(
            padding: EdgeInsets.all(8),
            child: FutureBuilder(
                future: _getAudioList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (_service.list.isEmpty) {
                    return const Center(
                      child: Text('Não há músicas'),
                    );
                  } else {
                    return Expanded(
                        child: ListView.builder(
                            itemCount: _service.list.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(_service.list[index].title),
                                subtitle: Text(_service.list[index].artist),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder:
                                  (context)=> AudioPlayerScreen(audio:_service.list[index])));
                                },
                              );
                            }));
                  }
                })));
  }
}
