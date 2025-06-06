import 'package:flutter/material.dart';
import 'package:hydrosmart/features/soil/domain/video.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hydrosmart/features/soil/constants/humidity_suggestions.dart';
import 'package:hydrosmart/features/soil/constants/temperature_suggestions.dart';

class RecommendedActionsPage extends StatefulWidget {
  const RecommendedActionsPage({super.key});

  @override
  State<RecommendedActionsPage> createState() => _RecommendedActionsPageState();
}

class _RecommendedActionsPageState extends State<RecommendedActionsPage> {
  late int _id;
  late bool _isHumidity;
  String _status = '';
  List<dynamic> _suggestions = [];
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final arguments = ModalRoute.of(context)?.settings.arguments;

      if (arguments is Map && arguments['id'] is int && arguments['isHumidity'] is bool) {
        _id = arguments['id'];
        _isHumidity = arguments['isHumidity'];
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No se pudieron cargar las recomendaciones. Volviendo...')),
          );
          Navigator.of(context).pop();
        });
        return;
      }

      _initialized = true;
      _fetchSuggestions();
    }
  }

  void _fetchSuggestions() {
    // TODO: Get the status from the API with the id
    switch (_id) {
      case 1:
        _status = 'FAVORABLE';
        break;
      case 2:
        _status = 'SLIGHTLY_UNFAVORABLE_UNDER';
        break;
      case 3:
        _status = 'SLIGHTLY_UNFAVORABLE_OVER';
        break;
      case 4:
        _status = 'UNFAVORABLE_UNDER';
        break;
      case 5:
        _status = 'UNFAVORABLE_OVER';
        break;
    }
    if (_isHumidity) {
      switch (_id) {
        case 6:
          _status = 'FLOODED';
          break;
        case 7:
          _status = 'DRY';
          break;
      }
      _suggestions = HUMIDITY_SUGGESTIONS[_status]?['videos'] as List<Video>? ?? [];
    } else {
      switch (_id) {
        case 6:
          _status = 'BURNING';
          break;
        case 7:
          _status = 'FREEZING';
          break;
      }
      _suggestions = TEMPERATURE_SUGGESTIONS[_status]?['videos'] as List<Video>? ?? [];
    }
    setState(() {});
  }

  String _getYoutubeId(String url) {
    final match = RegExp(r'(?:youtube\.com.*(?:\?|&)v=|youtu\.be\/)([^&\n?#]+)').firstMatch(url);
    return match?.group(1) ?? '';
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo abrir el video: $url')),
      );
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Volver',
        ),
        title: const Text(
          'Acciones recomendadas',
          style: TextStyle(fontWeight: FontWeight.bold),
          ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Te recomendamos estos tutoriales en base a los problemas detectados',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 960
                    ? 3
                    : (MediaQuery.of(context).size.width > 600 ? 2 : 1),
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1.0, // Adjust as needed
              ),
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                final video = _suggestions[index];
                final videoId = _getYoutubeId(video.url!);
                final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';

                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      _launchUrl(video.url!);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.network(
                            thumbnailUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(child: CircularProgressIndicator());
                            },
                            errorBuilder: (context, error, stackTrace) => const Center(
                              child: Icon(Icons.play_circle_outline, size: 48, color: Color(0xFF000000)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            video.title ?? 'Sin título',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
