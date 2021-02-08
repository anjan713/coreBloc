import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coreBloc/constants/enum.dart';
import 'package:coreBloc/logic/cubit/counter_state.dart';
import 'package:coreBloc/logic/cubit/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'cubit/internet_cubit.dart';
import 'cubit/internet_state.dart';


class CounterCubit extends Cubit<CounterState> {
  StreamSubscription internetStream;
  final InternetCubit internetCubit;

  CounterCubit({@required this.internetCubit})
      : super(CounterState(counterValue: 0)) {
    internetCounter();
  }

  void internetCounter() {
     internetStream = internetCubit.listen((connectionState) {
      if (connectionState is InternetConnectedState &&
          connectionState.connectiontype == ConnectionType.Wifi) {
        increment();
      }
      if (connectionState is InternetConnectedState &&
          connectionState.connectiontype == ConnectionType.Mobile) {
        decrement();
      }
    });
  }

  void increment() => emit(
      CounterState(counterValue: state.counterValue + 1, isIncremented: true));

  void decrement() => emit(
      CounterState(counterValue: state.counterValue - 1, isIncremented: false));
  @override
  Future<void> close() {
    internetStream.cancel();
    return super.close();
  }
}

