import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _items = ["Device", "Device sensors", "Check"];
  late String _selectedItems = _items[0];
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: Icon(Icons.phone_android),
        title: Text("Device Information"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: List.generate(
                _items.length,
                (index) => Expanded(
                  child: NavbarItem(
                    title: _items[index],
                    selectedItems: _selectedItems,
                    onPressed: () {
                      setState(() {
                        _selectedItems = _items[index];
                      });
                      _pageController.jumpToPage(index);
                    },
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 20,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedItems = _items[index];
                });
              },
              children: [
                // Import the plugin and decorate it in here
                Text("Device Information"),
                Text("Device sensors"),
                Text("Check"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NavbarItem extends StatefulWidget {
  const NavbarItem({
    super.key,
    required this.title,
    required this.onPressed,
    required this.selectedItems,
  });

  final String title;
  final VoidCallback? onPressed;
  final String selectedItems;

  @override
  State<NavbarItem> createState() => _NavbarItemState();
}

class _NavbarItemState extends State<NavbarItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.selectedItems == widget.title
          ? BoxDecoration(
              border: BoxBorder.fromLTRB(
                bottom: BorderSide(color: Colors.green.shade900, width: 5),
              ),
            )
          : null,
      child: TextButton(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        child: Text(widget.title),
      ),
    );
  }
}
