import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return FavoritesListView();
    // return FavoritesLargePictureListView();
    return const SafeArea(
      child: FavoritesGridView(),
    );
  }
}

class FavoritesGridView extends StatelessWidget {
  const FavoritesGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.extent(maxCrossAxisExtent: 250, children: [
      GridViewTile(),
      GridViewTile(),
      GridViewTile(),
      GridViewTile(),
    ]);
  }
}

class FavoritesLargePictureListView extends StatelessWidget {
  const FavoritesLargePictureListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      FavoriteListTile(),
      FavoriteListTile(),
      FavoriteListTile(),
    ]);
  }
}

class GridViewTile extends StatelessWidget {
  final bool showSubtitle;

  const GridViewTile({Key? key, this.showSubtitle = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Stack(
          fit: StackFit.expand,
          children: [
            FittedBox(
              fit: BoxFit.cover,
              child: Image.asset("assets/images/sample1.png"),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white.withOpacity(0.87),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Name des Werkes',
                        style: theme.textTheme.bodyText2,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      if(showSubtitle)
                        Text(
                          'Kurze Beschreibung des Werkes',
                          style: theme.textTheme.caption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteListTile extends StatelessWidget {
  const FavoriteListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.asset("assets/images/sample1.png", width: 150, height: 120),
          const SizedBox(
            width: 16.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name des Werkes',
                style: theme.textTheme.subtitle1,
              ),
              Text(
                'Kurze Beschreibung des Werkes',
                style: theme.textTheme.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FavoritesListView extends StatelessWidget {
  const FavoritesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      ListTile(
        leading: Image.asset("assets/images/sample1.png"),
        title: Text('Name des Werkes'),
        subtitle: Text('Kurze Beschreibung des Werkes'),
        isThreeLine: true,
      ),
      ListTile(
        leading: Image.asset("assets/images/sample1.png"),
        title: Text('Name des Werkes'),
        subtitle: Text('Kurze Beschreibung des Werkes'),
        isThreeLine: true,
      ),
      ListTile(
        leading: Image.asset("assets/images/sample1.png"),
        title: Text('Name des Werkes'),
        subtitle: Text('Kurze Beschreibung des Werkes'),
        isThreeLine: true,
      ),
      ListTile(
        leading: Image.asset("assets/images/sample1.png"),
        title: Text('Name des Werkes'),
        subtitle: Text('Kurze Beschreibung des Werkes'),
        isThreeLine: true,
      ),
    ]);
  }
}
