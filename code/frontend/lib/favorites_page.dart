import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) :  super(key: key);

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
  const GridViewTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Expanded(
            child: Image.asset("assets/images/sample1.png"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
          ),
        ],
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
