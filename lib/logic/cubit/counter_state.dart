import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class CounterState extends Equatable {
  int counterValue;
  bool isIncremented;
  CounterState({@required this.counterValue, this.isIncremented});

  @override
  List<Object> get props => [this.counterValue, this.isIncremented];

  Map<String, dynamic> toMap() {
    return {
      'counterValue': counterValue,
      'isIncremented': isIncremented,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CounterState(
      counterValue: map['counterValue'],
      isIncremented: map['isIncremented'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CounterState.fromJson(String source) =>
      CounterState.fromMap(json.decode(source));

  @override
  String toString() => 'CounterState(counterValue: $counterValue, isIncremented: $isIncremented,)';
}
