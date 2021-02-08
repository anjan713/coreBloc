import 'package:coreBloc/constants/enum.dart';
import 'package:equatable/equatable.dart';
// part of 'internet_cubit.dart';


abstract class InternetState extends Equatable {
  final ConnectionType connectiontype;

  InternetState(this.connectiontype);

  @override
  List<Object> get props => [];
}

class InternetLoading extends InternetState {
  InternetLoading(ConnectionType connectiontype) : super(connectiontype);
}

class InternetConnectedState extends InternetState {
  final ConnectionType connection;

  InternetConnectedState({this.connection}) : super(connection);
}

class InternetDisconnectedState extends InternetState {
  final ConnectionType connection;
  InternetDisconnectedState({this.connection})
      : super(connection);
}

