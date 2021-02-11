part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool appNotifications;
  final bool emailNotifications;
  @override
  SettingsState({this.appNotifications, this.emailNotifications});

  SettingsState copyWith({bool appNotifications, bool emailNotifications}) {
    return SettingsState(
        appNotifications: appNotifications ?? this.appNotifications,
        emailNotifications: emailNotifications ?? this.emailNotifications);
  }
  List<Object> get props => [emailNotifications,appNotifications];
}
