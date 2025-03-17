import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'examples/home_screen.dart';
// We'll create these screens next
import 'examples/01_basic/basic_chat_screen.dart';
import 'examples/02_intermediate/intermediate_chat_screen.dart';
import 'examples/03_advanced/advanced_chat_screen.dart';
import 'examples/04_specialized/specialized_home.dart';

// For state management
import 'models/app_state.dart';

/// Main entry point for the Flutter Gen AI Chat UI Example App
void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: Consumer<AppState>(
        builder: (context, appState, _) {
          return MaterialApp(
            title: 'Flutter Gen AI Chat UI Examples',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.indigo,
                brightness: Brightness.light,
              ),
              textTheme: GoogleFonts.interTextTheme(),
              useMaterial3: true,
            ),
            darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.indigo,
                brightness: Brightness.dark,
              ),
              textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
            ),
            themeMode: appState.themeMode,
            // Define all our routes
            initialRoute: '/',
            routes: {
              '/': (context) => const ExamplesHomeScreen(),
              '/basic': (context) => const BasicChatScreen(),
              '/intermediate': (context) => const IntermediateChatScreen(),
              '/advanced': (context) => const AdvancedChatScreen(),
              '/specialized': (context) => const SpecializedHomeScreen(),
            },
          );
        },
      ),
    );
  }
}

// For a more comprehensive example with advanced features:
// - See the 'comprehensive' directory which demonstrates:
//   - Streaming text responses
//   - Dark/light theme switching
//   - Custom message styling
//   - Animation control
//   - Markdown rendering with code blocks
