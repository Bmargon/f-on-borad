import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {

  final List items = <Widget>[
    _Board('assets/1.svg', 'Bienvendio', 'Esto es una página de prueba de un onboard.'),
    _Board('assets/2.svg', 'On Board', 'Esto es una página de prueba de un onboard.'),
    _Board('assets/3.svg', 'By', 'Esto es una página de prueba de un onboard.'),
    _Board('assets/4.svg', 'Bruneitor', 'Esto es una página de prueba de un onboard.'),
    _Board('assets/5.svg', 'Martinez', 'Esto es una página de prueba de un onboard.'),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Conexion(),
      child: MaterialApp(
        title: 'Material App',
        home: Scaffold(
          body: Column(
            children: <Widget>[
              Expanded(
                child: Scrollable(items: items),
              ),
              Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ...List.generate(this.items.length, (i) => Points(index: i))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Scrollable extends StatefulWidget {
  const Scrollable({
    Key key,
    @required this.items,
  }) : super(key: key);

  final List items;

  @override
  _ScrollableState createState() => _ScrollableState();
}

class _ScrollableState extends State<Scrollable> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      onPageChanged: (i) {
        setState(() {
          Provider.of<Conexion>(context, listen: false).currentPage = i;
        });
      },
      itemCount: this.widget.items.length,
      itemBuilder: (context, i) {
        return this.widget.items[i];
      }
    );
  }
}


class Points extends StatelessWidget {
  final int index;
  const Points({
    this.index,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: (this.index == Provider.of<Conexion>(context).currentPage) ? Colors.orange : Colors.grey
      ),
    );
  }
}

class _Board extends StatelessWidget{
  String path;
  String title;
  String subtitle;

  _Board(this.path, this.title, this.subtitle);

  @override
    Widget build(BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(height: 20,),
          Text(this.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50), textAlign: TextAlign.center,),
          SvgPicture.asset(
            this.path, 
            height: 300
          ),
          Text(this.subtitle,  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20), textAlign: TextAlign.center,),
        ],
      );
  }
}

class Conexion with ChangeNotifier{

  int _currentPage;

  get currentPage => this._currentPage;
  set currentPage(int value) {
    this._currentPage = value;
    notifyListeners();
  }
}