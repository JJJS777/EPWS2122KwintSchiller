import 'package:flutter/material.dart';
import 'package:frontend/favorites_page.dart';

class SearchPage extends StatelessWidget {

  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
          child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
          children: [
            Column(
              children: [
                TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0))),
                      suffixIcon: Icon(Icons.keyboard_voice),
                      hintText: 'Kunstwerkname eingeben',
                      labelText: 'Suche',
                    ),
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    }),
                SizedBox(height: 24,),
                Expanded( //??
                  child: Column(
                    children: [
                      Gallery(title: "Für dich empfohlen",),
                      Gallery(title: "Populär",),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                child: const Icon(Icons.mic),
                onPressed: () {},
              ),
            ),
          ],
      ),
    ),
        ));
  }
}

class Gallery extends StatelessWidget {
  final String title;

  const Gallery({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container( width: 150, child: AspectRatio(aspectRatio: 3 / 4, child: GridViewTile(showSubtitle: false,))),
              Container( width: 150, child: AspectRatio(aspectRatio: 3 / 4, child: GridViewTile(showSubtitle: false,))),
              Container( width: 150, child: AspectRatio(aspectRatio: 3 / 4, child: GridViewTile(showSubtitle: false,))),
              Container( width: 150, child: AspectRatio(aspectRatio: 3 / 4, child: GridViewTile(showSubtitle: false,))),
            ],
          ),
        ),
      ],
    );
  }
}

