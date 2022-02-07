import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:frontend/search_page.dart';
import 'package:frontend/services/artothek_client.dart';
import 'package:frontend/services/dialogflow_service.dart';

class ArtWorkDetailPage extends StatefulWidget {
  final Artwork? artwork;

  const ArtWorkDetailPage({Key? key, this.artwork}) : super(key: key);

  @override
  State<ArtWorkDetailPage> createState() => _ArtWorkDetailPageState();
}

class _ArtWorkDetailPageState extends State<ArtWorkDetailPage> {
  late StreamSubscription<DialogFlowIntent> _sub;
  bool added = false;

  @override
  void initState() {
    _sub = DialogFlowService.instance.onCommandRecognized.listen((value) async {
      if (value.command == DialogFlowCommand.addToFavorite && mounted) {
        try {
          await ArtothekClient.instance.addToFavorites(widget.artwork!.id);
          setState(() {
            added = true;
          });
          DialogFlowService.instance.speak(value.fullfilmentText);
        } catch (e) {
          DialogFlowService.instance.speak(
              'Etwas ist schief gegangen, bitte versuchen Sie es noch ein mal');
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ClipRect(
            child: AspectRatio(
              aspectRatio: 1,
              child: SizedBox(
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    FittedBox(
                      fit: BoxFit.cover,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: widget.artwork != null
                            ? Image.network(
                                widget.artwork!.primaryimage,
                                cacheWidth: 800,
                                cacheHeight: 1200,
                              )
                            : Image.asset("assets/images/sample1.png"),
                      ),
                    ),
                    SafeArea(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white54,
                                    shape: BoxShape.circle),
                                child: const BackButton(),
                              ),
                              Expanded(child: Container()),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white54,
                                    shape: BoxShape.circle),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.ios_share),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white54,
                                    shape: BoxShape.circle),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: added
                                      ? const Icon(Icons.favorite)
                                      : const Icon(Icons.favorite_border),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white70,
                    Colors.white54,
                    Colors.white24,
                  ],
                  stops: [0.1, 0.7, 1.0],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.artwork?.title ?? 'WerkXy',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      widget.artwork?.artist ?? 'Autorenname',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    // const Divider(),
                    if (false)
                      const SizedBox(
                        height: 8.0,
                      ),
                    if (false)
                      Text(
                        'Beschreibung',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const SizedBox(
                      height: 68,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 10,
          ),
          DialogFlowDetector(
            child: FloatingActionButton(
              child: const Icon(Icons.mic),
              onPressed: () {},
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26.0),
            ),
            height: 52,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('RESERVIEREN'),
            ),
          ),
        ],
      ),
    );
  }
}
