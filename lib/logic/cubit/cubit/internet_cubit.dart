import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:coreBloc/constants/enum.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
// part 'internet_state.dart';
import 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  Connectivity connectivity;
  StreamSubscription internetConnectionStream;

  InternetCubit({@required this.connectivity}) : super(InternetLoading(ConnectionType.None)) {
    monitorConnection();
  }

  void monitorConnection() {
    internetConnectionStream =
        connectivity.onConnectivityChanged.listen((connectionState) {
      print('internet Cubit $connectionState');
      if (connectionState == ConnectivityResult.wifi) {
        emitConnectionEstablished(ConnectionType.Wifi);
      } else if (connectionState == ConnectivityResult.mobile) {
        emitConnectionEstablished(ConnectionType.Mobile);
      } else if (connectionState == ConnectivityResult.none) {
        emitConnectionTerminated(ConnectionType.None);
      }
    });
  }

  emitConnectionEstablished(ConnectionType type) =>
      emit( InternetConnectedState(connection: type));

  emitConnectionTerminated(ConnectionType type) => emit( InternetDisconnectedState(connection: type));

  @override
  Future<void> close() {
    internetConnectionStream.cancel();
    return super.close();
  }
}

