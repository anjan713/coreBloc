import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:coreBloc/logic/cubit/cubit/internet_cubit.dart';
import 'package:coreBloc/presentation/routes/app_router.dart';
import 'package:coreBloc/presentation/screens/homeScreen.dart';
import 'package:coreBloc/presentation/screens/secondScreen.dart';
import 'package:coreBloc/presentation/screens/thirdScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'logic/cubit/counter_cubit.dart';
import 'logic/cubit/counter_state.dart';
import 'logic/cubit/cubit/settings_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
storageDirectory: await getApplicationDocumentsDirectory(),
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() =>
      _MyAppState(appRouter: AppRouter(), connectivity: Connectivity());
}

class _MyAppState extends State<MyApp> {
  final AppRouter appRouter;
  final Connectivity connectivity;

  _MyAppState({this.connectivity, this.appRouter});
  @override
  void dispose() {
    // appRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<InternetCubit>(
            create: (context) => InternetCubit(connectivity: connectivity),
          ),
          BlocProvider<CounterCubit>(
              create: (context) => CounterCubit(
                  internetCubit: BlocProvider.of<InternetCubit>(context))),
          BlocProvider(
            create: (context) => SettingsCubit(),
            child: Container(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          // routes: {
          //   '/':(context)=> MyHomePage(
          //     title:'Home Screen',
          //   ),
          //   '/second':(context)=> SecondScreen(),
          //   '/third':(context) => ThirdScreen(),
          // },

          onGenerateRoute: appRouter.onGenerated,
          // home: MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}
