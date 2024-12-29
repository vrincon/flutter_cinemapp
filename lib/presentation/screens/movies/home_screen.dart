import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:cinemapedia/presentation/views/views.dart';



class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';
  final int pageIndex;

  const HomeScreen({
    super.key, 
    required this.pageIndex
  });

  final viewsRoutes = const <Widget>[
    HomeView(),
    CategoriesView(),
    FavoritesView(),
  ];

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewsRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigation( currentIndex: pageIndex),
    );
  }
}
