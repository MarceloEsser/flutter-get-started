import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:workshop/model/icoded.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:workshop/repository/http/services/icoded_web_client.dart';

class IcodedBloc implements BlocBase {
  final IcodedWebClient webClient;

  List<Icoded> _apiIcoders = [];

  IcodedBloc({@required this.webClient});

  StreamController<List<Icoded>> _IcodersController =
  StreamController<List<Icoded>>();

  Stream<List<Icoded>> get outIcoders => _IcodersController.stream;

  Sink<List<Icoded>> get inIcoders => _IcodersController.sink;

  @override
  void addListener(listener) {
    _IcodersController.onListen = listener;
  }

  @override
  void dispose() {
    _IcodersController.close();
  }

  @override
  bool get hasListeners => _IcodersController.hasListener;

  @override
  void notifyListeners() {}

  @override
  void removeListener(listener) {
    if (_IcodersController.hasListener) {
      _IcodersController.onCancel = listener;
    }
  }

  void loadIcoders() async {
    _apiIcoders = await webClient.getAllIcoders();
    inIcoders.add(_apiIcoders);
  }

  bool _hasIcoders() => _apiIcoders != null && _apiIcoders.length > 0;
}
