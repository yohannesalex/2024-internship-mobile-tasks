import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc_observer.dart';
import 'features/eCommerce/domain/entities/product.dart';
import 'features/eCommerce/presentation/bloc/product_bloc.dart';
import 'features/eCommerce/presentation/pages/add_page.dart';
import 'features/eCommerce/presentation/pages/details_page.dart';
import 'features/eCommerce/presentation/pages/edit_page.dart';
import 'features/eCommerce/presentation/pages/home_page.dart';
import 'features/eCommerce/presentation/pages/search_page.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  await di.init();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProductBloc(
              sl(),
              sl(),
              sl(),
              sl(),
              sl(),
            )..add(LoadAllProductEvent()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: '/',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return _buildPageRoute(Home());
              case '/details':
                return _buildPageRoute(
                    const Detail(
                      product: ProductEntity(
                          id: '',
                          name: '',
                          description: '',
                          price: 0,
                          imageUrl: ''),
                    ),
                    fromMiddleDown: true);
              case '/search':
                return _buildPageRoute(const Search());
              case '/add':
                return _buildPageRoute(const Add());
              case '/edit':
                return _buildPageRoute(Edit());
              default:
                return null;
            }
          },
          theme: ThemeData(
              textTheme: GoogleFonts.poppinsTextTheme(),
              primaryColor: const Color.fromARGB(255, 63, 81, 243),
              colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color.fromARGB(255, 63, 81, 243))),
        ));
  }

  PageRouteBuilder _buildPageRoute(Widget page, {bool fromMiddleDown = false}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin =
            fromMiddleDown ? const Offset(0.0, 0.0) : const Offset(1.0, 0.0);
        final end = fromMiddleDown ? const Offset(0.0, 1.0) : Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
