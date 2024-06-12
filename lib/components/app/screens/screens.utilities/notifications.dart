import 'package:flutter/material.dart';
import 'package:grupchat/main.dart';
import 'package:grupchat/models/notification.dart';
import 'package:grupchat/services/auth_service.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:grupchat/widgets/show_snackbar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NotificationsScreen extends StatefulWidget {
  static const String routeName = '/notifications';
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final AuthService _authService = AuthService();
  List<NotificationItem> _notifications = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final notifications = await _authService
          .getUserNotifications(supabase.auth.currentUser!.id);
      setState(() {
        _isLoading = false;
        _notifications = notifications;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: SingleChildScrollView(
        child: _isLoading
            ? Column(
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.4,
                  ),
                  Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                        color: kPrimaryColor,
                        size: SizeConfig.screenHeight * 0.05),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.4,
                  )
                ],
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _notifications.isEmpty ? 1 : _notifications.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_notifications.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.4,
                        ),
                        const Text("No New Notifications"),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.4,
                        )
                      ],
                    );
                  }
                  final notification = _notifications[index];
                  return ListTile(
                    onTap: () {
                      // Handle notification tap
                    },
                    title: Text(notification.title),
                    subtitle: Text(notification.body),
                    trailing: Text(notification.createdAt),
                  );
                }),
      ),
    );
  }
}
