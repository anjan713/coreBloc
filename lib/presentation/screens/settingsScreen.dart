import 'package:coreBloc/logic/cubit/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Column(
        children: [
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return SwitchListTile(
                  value:
                      context.watch<SettingsCubit>().state.emailNotifications,
                  onChanged: (newValue) {
                    context.read<SettingsCubit>().toggleEmailNotifications(newValue);
                  },
                  title: Text('emailnotifications'),);
            },
          ),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return SwitchListTile(
                value: state.appNotifications,
                onChanged: (val) {
                  print('appSwitch $val');
                  context.read<SettingsCubit>().toggleAppNotifications(val);
                },
                title: Text('AppSwitch'),
              );
            },
          ),
          BlocListener<SettingsCubit, SettingsState>(
            listener: (context, state) {
              return Scaffold.of(context).showSnackBar(SnackBar(
                  duration: Duration(milliseconds: 700),
                  content: Text(
                      'appNotifications ${state.appNotifications} & emailNotifications ${state.emailNotifications}')));
            },
            child: Container(),
          ),
          
        ],
      ),
    );
  }
}
