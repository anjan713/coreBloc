import 'package:coreBloc/logic/cubit/counter_cubit.dart';
import 'package:coreBloc/logic/cubit/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThirdScreen extends StatefulWidget {
  ThirdScreen({Key key}) : super(key: key);

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text('Third Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            BlocListener<CounterCubit, CounterState>(
              listener: (context, state) {
                return Scaffold.of(context).showSnackBar(SnackBar(
                  content:
                      Text(state.isIncremented ? 'incremented' : 'decremented'),
                  backgroundColor:
                      state.isIncremented ? Colors.yellow : Colors.red,
                  duration: Duration(milliseconds: 200),
                ));
              },
              child: Container(),
            ),
            BlocBuilder<CounterCubit, CounterState>(
              builder: (context, state) {
                if (state.counterValue < 0) {
                  return Text(
                    'Negative' + state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                }
                return Text(
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  backgroundColor: Colors.yellow,
                  heroTag: 'btn21',
                  tooltip: 'Increment',
                  child: Icon(Icons.add),
                ),
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  backgroundColor: Colors.yellow,
                  heroTag: 'btn22',
                  tooltip: 'Decrement',
                  child: Icon(Icons.remove),
                ),
                SizedBox(
                  height: 24,
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  child: Text('third Screen'),
                  color: Colors.yellow,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
