import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pagoda_tgu/HomePage.dart';
import 'package:pagoda_tgu/provider/ListenerProvider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider<ListenerProvider>(
      create: (_) => ListenerProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              final provider =
                  Provider.of<ListenerProvider>(context, listen: false);

              final homePage = HomePage(provider);

           return Stack(
                  children: [
                    GameWidget(
                      game: homePage,
                    ),
                    Selector<ListenerProvider, bool>(
                      selector: (context, listenerProvider) =>
                          listenerProvider.isPickChickenInTable!,
                      builder: (context, isStatus, child) {
                        if (isStatus) {
                          return Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Nhập ước nguyện vào',
                                      ),
                                    ),
                                  ),
                                  
                                  ElevatedButton(
                                        onPressed: () {
                                          provider.isShowQuestion = true;
                                          var rng = Random();
                                          provider.setRamomSelect = rng.nextInt(2);
                                        },
                                        child: const Text('Gửi'),
                                      ),
                               
                                ],
                              ),
                            ),
                          );
                        } else {
                          return SizedBox.shrink(); // Empty widget, won't be rebuilt
                        }
                      },
                    ),
                  ],
                );

            },
          ),
        ),
      ),
    ),
  );
}
