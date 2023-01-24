import 'package:flutter/material.dart';
import 'package:project_test/screens/pages/pages.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key, required this.presenter}) : super(key: key);

  final SplashPresenter presenter;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    widget.presenter.checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
