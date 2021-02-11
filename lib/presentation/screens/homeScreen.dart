import 'package:coreBloc/constants/enum.dart';
import 'package:coreBloc/logic/cubit/counter_cubit.dart';
import 'package:coreBloc/logic/cubit/counter_state.dart';
import 'package:coreBloc/logic/cubit/cubit/internet_cubit.dart';
import 'package:coreBloc/presentation/screens/settingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/cubit/internet_state.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void choiceAction(String choice){
    if (choice == 'Settings') {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen()));
    }
    if (choice =='logout') {
      print('Logout');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
         PopupMenuButton(
            onSelected:choiceAction ,
            itemBuilder: (context) {
            return {'logout', 'Settings'}.map((String e) {
              return PopupMenuItem(
                child: Text(e),
                value: e,
              );
            }).toList();
          })
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                print(state.connectiontype);
                if (state.connectiontype == ConnectionType.Wifi &&
                    state is InternetConnectedState) {
                  return Text(
                    'Wifi',
                    style: TextStyle(color: Colors.green, fontSize: 48),
                  );
                } else if (state.connectiontype == ConnectionType.Mobile &&
                    state is InternetConnectedState) {
                  return Text(
                    'mobile',
                    style: TextStyle(color: Colors.green, fontSize: 48),
                  );
                } else if (state is InternetDisconnectedState) {
                  return Text(
                    'error',
                    style: TextStyle(color: Colors.red, fontSize: 48),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            BlocListener<CounterCubit, CounterState>(
              listener: (context, state) {
                return Scaffold.of(context).showSnackBar(SnackBar(
                  content:
                      Text(state.isIncremented ? 'incremented' : 'decremented'),
                  backgroundColor:
                      state.isIncremented ? Colors.green : Colors.red,
                  duration: Duration(milliseconds: 200),
                ));
              },
              child: Container(),
            ),
            // BlocBuilder<CounterCubit, CounterState>(
            //   builder: (context, state) {
            //     if (state.counterValue < 0) {
            //       return Text(
            //         'Negative' + state.counterValue.toString(),
            //         style: Theme.of(context).textTheme.headline4,
            //       );
            //     }
            //     return Text(
            //       state.counterValue.toString() ?? '7',
            //       style: Theme.of(context).textTheme.headline4,
            //     );
            //   },
            // ),
            Builder(builder: (context) {
              print('I got rebulit');
              final counterState = context.watch<CounterCubit>();
              final internetState = context.watch<InternetCubit>();
              print(counterState.state.counterValue);
              if (internetState.state is InternetConnectedState &&
                  internetState.state.connectiontype == ConnectionType.Mobile) {
                return Text(
                  'Counter:${counterState.state.counterValue ?? 0} Connection: Mobile',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 24),
                );
              } else if (internetState.state is InternetConnectedState &&
                  internetState.state.connectiontype == ConnectionType.Wifi) {
                return Text(
                  'Counter:${counterState.state.counterValue ?? 0} Connection: Wifi',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 24),
                );
              }
              if (internetState.state is InternetDisconnectedState &&
                  internetState.state.connectiontype == ConnectionType.None) {
                return Text(
                  'Counter:${counterState.state.counterValue ?? 0} Connection: Disconnected',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 24),
                );
              }
              return CircularProgressIndicator();
            }),
            SizedBox(
              height: 24,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    context.read<CounterCubit>().increment();
                    // BlocProvider.of<CounterCubit>(context).increment();
                  },
                  tooltip: 'Increment',
                  heroTag: 'btn11',
                  child: Icon(Icons.add),
                ),
                FloatingActionButton(
                  onPressed: () {
                    context.read<CounterCubit>().decrement();
                    // BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  tooltip: 'Decrement',
                  heroTag: 'btn12',
                  child: Icon(Icons.remove),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              child: Text('Second Screen'),
            ),
            SizedBox(
              height: 24,
            ),
            MaterialButton(
              onPressed: () {
                sheet(context);
              },
              child: Text('show Sheet'),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  sheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            padding: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              children: [
                BlocBuilder<CounterCubit, CounterState>(
                  builder: (context, state) {
                    return Text(
                      state.counterValue.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    );
                  },
                ),
                FloatingActionButton(onPressed: () {
                  BlocProvider.of<CounterCubit>(context).increment();
                }),
              ],
            ),
          );
        });
  }
}
