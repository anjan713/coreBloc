import 'package:coreBloc/logic/cubit/counter_cubit.dart';
import 'package:coreBloc/presentation/screens/homeScreen.dart';
import 'package:coreBloc/presentation/screens/secondScreen.dart';
import 'package:coreBloc/presentation/screens/thirdScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  // CounterCubit cubit = CounterCubit();
  Route onGenerated(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => 
            // BlocProvider.value(
                  // value: cubit,
                  // child: 
                  MyHomePage(
                    title: 'first screen',
                  // ),
                ));
        break;
      // case '/second':
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider.value(
      //             value:  cubit,
      //             child: SecondScreen(
      //                 // title: 'first screen',
      //                 ),
      //           ));
      //   break;
      // case '/third':
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider.value(
      //             value: cubit,
      //             child: ThirdScreen(
      //                 // title: 'first screen',
      //                 ),
      //           ));
      //   break;
      // default:
      //   return null;
      // return MaterialPageRoute(builder: (_)=>ErrorScreen())
    }
  }

  // void dispose() {
  //   cubit.close();
  // }
}
