import 'package:alarmfy/src/ui/pages/my_library_page.dart';
import 'package:alarmfy/src/ui/pages/search_page.dart';
import 'package:alarmfy/src/ui/pages/start_page.dart';
import 'package:alarmfy/src/ui/screens/home_screen.dart';
import 'package:alarmfy/src/ui/screens/login_screen.dart';
import 'package:alarmfy/src/ui/screens/temp_screen.dart';
import 'package:alarmfy/src/ui/tab_bar_views/album_tabBarView.dart';
import 'package:alarmfy/src/ui/tab_bar_views/artist_tabBarView.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('My library', (WidgetTester tester) async {
    var widget = MyLibraryPage();
    await tester.pumpWidget(widget);
    expect(find.text('Listas de reproducción'), findsOneWidget);
  });
  testWidgets('Search', (WidgetTester tester) async {
    var widget = MyLibraryPage();
    await tester.pumpWidget(widget);
    expect(find.text('Buscar'), findsOneWidget);
  });
  testWidgets('Start', (WidgetTester tester) async {
    var widget = StartPage();
    await tester.pumpWidget(widget);
    expect(find.text('Inicio'), findsOneWidget);
  });
  testWidgets('Home', (WidgetTester tester) async {
    var widget = HomeScreen();
    await tester.pumpWidget(widget);
    expect(find.text('AppiMusic'), findsOneWidget);
  });
  testWidgets('Temp', (WidgetTester tester) async {
    var widget = TempScreen();
    await tester.pumpWidget(widget);
    expect(
        find.text(
            'Una aplicación que te permite consultar tus Playlist y reproducir canciones'),
        findsOneWidget);
  });
  testWidgets('Artists', (WidgetTester tester) async {
    var widget = AlbumTabBar();
    await tester.pumpWidget(widget);
    expect(find.text('Artists'), findsOneWidget);
  });
}
