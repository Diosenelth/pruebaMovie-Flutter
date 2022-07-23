import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pruebamovie_flutter/provider.dart';

void main() {
  // consultar();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text("PruebaMovie"),
            ),
            body: Stack(
              children: [
                ChangeNotifierProvider<ProviderMovie>(
                  create: (context) => ProviderMovie(),
                  child: Consumer<ProviderMovie>(
                    builder: (context, provider, child) {
                      if (provider.movies == null) {
                        provider.consultar();
                        return const Center(child: CircularProgressIndicator());
                      }
                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 3 / 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemCount: provider.movies?.length,
                          itemBuilder: (context, index) {
                            final movie = provider.movies![index];
                            return Column(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: FadeInImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                                    placeholder:
                                        const AssetImage('assets/no-image.jpg'),
                                    fit: BoxFit.cover,
                                    height: 85.0,
                                    width: 85.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  movie.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            );
                          });
                    },
                  ),
                )
              ],
            )));
  }
}
