import 'package:flutter/material.dart';
import 'package:parking/components/mainbody.dart';
import 'package:parking/components/myAccount.dart';

class HomeBody extends StatefulWidget {
  final int index;
  const HomeBody({
    super.key,
    required this.index,
  });

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (widget.index == 0)
      return MainBody(width: width);
    else if (widget.index == 1)
      return MyAccount();
    else
      return Kl();
  }
}

class Kl extends StatefulWidget {
  const Kl({super.key});

  @override
  State<Kl> createState() => _KlState();
}

class _KlState extends State<Kl> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('"woooooooooooooooooow"'),
    );
  }
}
