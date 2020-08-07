import 'package:flutter/material.dart';
import 'package:flutter_searchbar_animation/SearchBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'
    as FlutterScreenUtil;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  /// 是否展示搜索页
  bool _showSearch = false;

  /// 动画时间 0 无动画
  int _duration = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    FlutterScreenUtil.ScreenUtil.init(
      context,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Stack(
        children: <Widget>[
          AnimatedPositioned(
              key: Key('bar'),
              top: _showSearch
                  ? (-kToolbarHeight -
                      FlutterScreenUtil.ScreenUtil.statusBarHeight)
                  : 0,
              left: 0,
              right: 0,
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: _duration),
              child: AppBar(
                title: Text(widget.title),
              )),
          AnimatedPositioned(
            key: Key('content'),
            top: !_showSearch
                ? kToolbarHeight + FlutterScreenUtil.ScreenUtil.statusBarHeight
                : FlutterScreenUtil.ScreenUtil.statusBarHeight,
            left: 0,
            right: 0,
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: _duration),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 0,
                ),
                SearchBar(
                  onEdit: () {
                    print("onEdit");
                    setState(() {
                      _showSearch = true;
                      _duration = 300;
                    });
                  },
                  onCancel: () {
                    print("onEdit");
                    setState(() {
                      _showSearch = false;
                      _duration = 300;
                    });
                  },
                ),
                // Text(
                //   'You have pushed the button this many times:',
                // ),
                // Text(
                //   '$_counter',
                //   style: Theme.of(context).textTheme.headline4,
                // ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
