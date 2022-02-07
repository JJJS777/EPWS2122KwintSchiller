import 'package:flutter/material.dart';
import 'package:frontend/favorites_page.dart';
import 'package:frontend/services/artothek_client.dart';
import 'package:frontend/services/dialogflow_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Artwork>? _artworks;
  List<Artwork>? _recommendations;


  @override
  void initState() {
    ArtothekClient.instance.listArtworks().then((value) {
      setState(() {
        _artworks = value;
      });
    });

    ArtothekClient.instance.getUserRecommendations().then((value) {
      setState(() {
        _recommendations = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                children: [
                  TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                        suffixIcon: Icon(Icons.keyboard_voice),
                        hintText: 'Kunstwerkname eingeben',
                        labelText: 'Suche',
                      ),
                      onSaved: (String? value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      }),
                  const SizedBox(
                    height: 24,
                  ),
                  Expanded(
                    //??
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Gallery(
                              title: "Für dich empfohlen",
                              artworks: _recommendations),
                          Gallery(title: "Populär", artworks: _artworks),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              DialogFlowDetector(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    child: const Icon(Icons.mic),
                    onPressed: null,
                    backgroundColor: Colors.orangeAccent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Gallery extends StatelessWidget {
  final String title;
  final List<Artwork>? artworks;

  const Gallery({Key? key, required this.title, this.artworks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: artworks
                      ?.map((e) => SizedBox(
                          width: 150,
                          child: AspectRatio(
                              aspectRatio: 3 / 4,
                              child: GridViewTile(
                                showSubtitle: false,
                                title: e.title,
                                picture: e.primaryimage,
                                artwork: e,
                              ))))
                      .toList() ??
                  []
              /*[
              Container( width: 150, child: AspectRatio(aspectRatio: 3 / 4, child: GridViewTile(showSubtitle: false,))),
              Container( width: 150, child: AspectRatio(aspectRatio: 3 / 4, child: GridViewTile(showSubtitle: false,))),
              Container( width: 150, child: AspectRatio(aspectRatio: 3 / 4, child: GridViewTile(showSubtitle: false,))),
              Container( width: 150, child: AspectRatio(aspectRatio: 3 / 4, child: GridViewTile(showSubtitle: false,))),
            ],*/
              ),
        ),
      ],
    );
  }
}

//to record the voice: on press handleStream/stop stream
class DialogFlowDetector extends StatelessWidget {
  final Widget? child;

  const DialogFlowDetector({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (details) async {
        await DialogFlowService.instance.initPlugin();
        DialogFlowService.instance.handleStream();
      },
      onLongPressEnd: (details) {
        DialogFlowService.instance.stopStream();
      },
      child: child,
    );
  }
}
