import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:workshop/bloc/home_bloc.dart';
import 'package:workshop/model/icoded.dart';
import 'package:workshop/view/widget/centerd_loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  IcodedBloc bloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.loadIcoders();
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.getBloc();

    return Scaffold(
      appBar: AppBar(title: Text("YO")),
      body: StreamBuilder<List<Icoded>>(
        initialData: [],
        stream: bloc.outIcoders,
        builder: (context, snapshot) {
          final List<Icoded> icoders = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: CenteredLoader(),
              );
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              if (icoders.isNotEmpty) {
                return ListView.builder(
                  itemCount: icoders.length,
                  itemBuilder: (context, index) {
                    final Icoded icoded = icoders[index];
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                      child: Material(
                        elevation: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      icoded.name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blueAccent),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Text(icoded.description),
                                    ),
                                    Text(icoded.luckyNumber.toString(),
                                        style: TextStyle(color: Colors.red)),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Visibility(
                                    visible: icoded.loveTransformers,
                                    child: Image(
                                      height: 64,
                                      width: 64,
                                      image:
                                          AssetImage("images/autobot_icon.png"),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return Center(
                child: Text(
                  'Não á itens na lista',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              );
          }
          return Text('Unknown error');
        },
      ),
    );
  }
}
