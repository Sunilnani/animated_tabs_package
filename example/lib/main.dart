import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_animated_tabs/my_animated_tabs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Tabs Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  // 1) Define your tab/content colors once and for all
  final List<Color> _cardColors = const [
    Color(0xfffa86be),
    Color(0xffa275e3),
    Color(0xff9aebed),
  ];


  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Animated Tabs')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),

            Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(50),
              child: TabContainer(
               // controller: _controller,
                tabEdge: TabEdge.top,
                borderRadius: BorderRadius.circular(50),
                tabBorderRadius: BorderRadius.circular(50),
                tabMinLength: 80,
                tabMaxLength: 120,
                tabsStart: 0.1,
                tabsEnd: 0.9,
                colors: _cardColors,
                curve: Curves.easeInOut,
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: Tween(begin: 0.95, end: 1.0)
                        .chain(CurveTween(curve: Curves.easeOutBack))
                        .animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                selectedTextStyle: textTheme.bodyMedium
                    ?.copyWith(color: Colors.white, fontSize: 14),
                unselectedTextStyle: textTheme.bodyMedium
                    ?.copyWith(color: Colors.black54, fontSize: 13),
                tabs: const [Text('Card A'), Text('Card B'), Text('Card C')],
                children: _buildCards(),
              ),
            ),

            const SizedBox(height: 20),
            Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(50),
              child: TabContainer(
               // controller: _controller,
                tabEdge: TabEdge.bottom,
                borderRadius: BorderRadius.circular(50),
                tabBorderRadius: BorderRadius.circular(50),
                tabMinLength: 80,
                tabMaxLength: 120,
                tabsStart: 0.1,
                tabsEnd: 0.9,
                colors: _cardColors,
                curve: Curves.easeInOut,
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: Tween(begin: 0.95, end: 1.0)
                        .chain(CurveTween(curve: Curves.easeOutBack))
                        .animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                selectedTextStyle: textTheme.bodyMedium
                    ?.copyWith(color: Colors.white, fontSize: 14),
                unselectedTextStyle: textTheme.bodyMedium
                    ?.copyWith(color: Colors.black54, fontSize: 13),
                tabs: const [
                  Icon(Icons.credit_card),
                  Icon(Icons.payment),
                  Icon(Icons.account_balance),
                ],
                children: _buildCards(),
              ),
            ),

            const SizedBox(height: 40),


            // ——————————————————————————————————————————
            // Top tabs with colored background & matching cards
            SizedBox(
              width: 400,
              child: AspectRatio(
                aspectRatio: 10 / 8,
                child: TabContainer(
                  tabEdge: TabEdge.top,
                  borderRadius: BorderRadius.circular(20),
                  transitionBuilder: (child, animation) {
                    final curved = CurvedAnimation(
                      curve: Curves.easeIn,
                      parent: animation,
                    );
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.2, 0.0),
                        end: Offset.zero,
                      ).animate(curved),
                      child: FadeTransition(
                        opacity: curved,
                        child: child,
                      ),
                    );
                  },
                  curve: Curves.easeIn,
                  colors: _cardColors,
                  selectedTextStyle:
                  textTheme.bodyMedium?.copyWith(fontSize: 15.0),
                  unselectedTextStyle:
                  textTheme.bodyMedium?.copyWith(fontSize: 13.0),
                  tabs: _buildTabs1(),
                  children: _buildChildren1(),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ——————————————————————————————————————————
            // Bottom tabs example (unchanged)
            SizedBox(
              width: 400,
              child: AspectRatio(
                aspectRatio: 10 / 8,
                child: TabContainer(
                  borderRadius: BorderRadius.circular(20),
                  tabEdge: TabEdge.bottom,
                  curve: Curves.easeIn,
                  transitionBuilder: (child, animation) {
                    final curved = CurvedAnimation(
                      curve: Curves.easeIn,
                      parent: animation,
                    );
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.2, 0.0),
                        end: Offset.zero,
                      ).animate(curved),
                      child: FadeTransition(
                        opacity: curved,
                        child: child,
                      ),
                    );
                  },
                  colors: _cardColors,
                  selectedTextStyle:
                  textTheme.bodyMedium?.copyWith(fontSize: 15.0),
                  unselectedTextStyle:
                  textTheme.bodyMedium?.copyWith(fontSize: 13.0),
                  tabs: _buildTabs1(),
                  children: _buildChildren1(),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ——————————————————————————————————————————
            // Controller-driven (unchanged)
            SizedBox(
              height: 320,
              width: 400,
              child: TabContainer(
                controller: _controller,
                borderRadius: BorderRadius.zero,
                tabBorderRadius: BorderRadius.zero,
                color: Colors.black,
                duration: const Duration(seconds: 0),
                selectedTextStyle:
                textTheme.bodyMedium?.copyWith(color: Colors.white),
                unselectedTextStyle:
                textTheme.bodyMedium?.copyWith(color: Colors.black),
                tabs: _getTabs2(),
                children: _getChildren2(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () =>
                  _controller.index = max(_controller.index - 1, 0),
                  icon: const Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () => _controller.index =
                      min(_controller.index + 1, _controller.length - 1),
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // ——————————————————————————————————————————
            // Right-edge tabs (unchanged)
            SizedBox(
              width: 400,
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TabContainer(
                  color: Colors.orange.shade100,
                  tabEdge: TabEdge.right,
                  childPadding: const EdgeInsets.all(20.0),
                  tabs: _getTabs3(context),
                  children: _getChildren3(context),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ——————————————————————————————————————————
            // Left-edge tabs (unchanged)
            SizedBox(
              width: 400,
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TabContainer(
                  color: Theme.of(context).colorScheme.primary,
                  tabEdge: TabEdge.left,
                  tabsStart: 0.1,
                  tabsEnd: 0.6,
                  childPadding: const EdgeInsets.all(20.0),
                  tabs: _getTabs4(),
                  selectedTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                  unselectedTextStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 13.0,
                  ),
                  children: _getChildren4(),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCards() {
    final sampleData = [
      {'bank': 'Aerarium', 'number': '5234 4321 1234 4321', 'exp': '11/25'},
      {'bank': 'Fiscal One', 'number': '4234 0567 8901 2345', 'exp': '07/24'},
      {'bank': 'Aurora', 'number': '6789 1234 5678 9012', 'exp': '09/23'},
    ];

    return List.generate(sampleData.length, (i) {
      final data = sampleData[i];
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 6),
            )
          ],
        ),
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              data['bank']!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              data['number']!,
              style:TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            Text('Exp: ${data['exp']}'),
          ],
        ),
      );
    });
  }


  // ——————————————————————————————————————————
  // Updated helpers for the “colored cards” example:

  List<Widget> _buildTabs1() {
    return List<Widget>.generate(_cardColors.length, (i) {
      final num = kCreditCards[i]['number'] as String;
      final last4 = num.substring(num.length - 4);
      return Text('*$last4');
    });
  }

  List<Widget> _buildChildren1() {
    final cards = kCreditCards
        .map((e) => CreditCardData.fromJson(e))
        .toList();
    return List<Widget>.generate(cards.length, (i) {
      return CreditCard(
        color: _cardColors[i],
        data: cards[i],
      );
    });
  }

  // ——————————————————————————————————————————
  // Your existing other tabs:

  List<Widget> _getChildren2() => <Widget>[
    Image.network(
      'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?q=80&w=400&auto=format&fit=crop',
    ),
    Image.network(
      'https://images.unsplash.com/photo-1494905998402-395d579af36f?q=80&w=400&auto=format&fit=crop',
    ),
    Image.network(
      'https://images.unsplash.com/photo-1583121274602-3e2820c69888?q=80&w=400&auto=format&fit=crop',
    ),
  ];
  List<Widget> _getTabs2() => const [
    Text('Image 1'),
    Text('Image 2'),
    Text('Image 3'),
  ];

  List<Widget> _getChildren3(BuildContext context) => <Widget>[
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Info', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 20),
        const Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam non ex ac metus facilisis pulvinar.',
        ),
      ],
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Documents', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 20),
        const Text('Document 1'),
        const Divider(),
        const Text('Document 2'),
        const Divider(),
        const Text('Document 3'),
      ],
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Profile', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 20),
        Row(
          children: const [
            Text('Username:'),
            SizedBox(width: 10),
            Text('John Doe'),
          ],
        ),
        Row(
          children: const [
            Text('Email:'),
            SizedBox(width: 10),
            Text('john.doe@email.com'),
          ],
        ),
        Row(
          children: const [
            Text('Birthday:'),
            SizedBox(width: 10),
            Text('1/1/1985'),
          ],
        ),
      ],
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Settings', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 20),
        SwitchListTile(
          title: const Text('Darkmode'),
          value: false,
          onChanged: (v) {},
          secondary: const Icon(Icons.nightlight_outlined),
        ),
        SwitchListTile(
          title: const Text('Analytics'),
          value: false,
          onChanged: (v) {},
          secondary: const Icon(Icons.analytics),
        ),
      ],
    ),
  ];

  List<Widget> _getTabs3(BuildContext context) => const [
    Icon(Icons.info),
    Icon(Icons.text_snippet),
    Icon(Icons.person),
    Icon(Icons.settings),
  ];

  List<Widget> _getChildren4() => <Widget>[
    SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Page 1',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white)),
          const SizedBox(height: 50),
          const Text(
            '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur scelerisque est ac suscipit interdum. Donec accumsan metus sed purus ullamcorper tincidunt.''',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    ),
    SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Page 2',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white)),
          const SizedBox(height: 50),
          const Text(
            '''Duis in tortor nisl. Vestibulum vitae ullamcorper urna. Donec pharetra laoreet lacus, non sagittis ante aliquet eget.''',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    ),
    SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Page 3',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white)),
          const SizedBox(height: 50),
          const Text(
            '''Phasellus a rutrum lectus. Aenean sed mauris non augue hendrerit volutpat.''',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    ),
  ];

  List<Widget> _getTabs4() =>
      const [Text('1'), Text('2'), Text('3')];
}

/// CreditCard widget and model
class CreditCard extends StatelessWidget {
  final Color? color;
  final CreditCardData data;

  const CreditCard({
    super.key,
    this.color,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final bg = color ?? Colors.transparent;
    final isDark = bg.computeLuminance() < 0.5;
    final textColor = isDark ? Colors.white : Colors.black;

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.bank,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: textColor),
                ),
                Icon(Icons.person, size: 36, color: textColor),
              ],
            ),
          ),
          const Spacer(flex: 2),
          Expanded(
            flex: 5,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                data.number,
                style: TextStyle(fontSize: 22.0, color: textColor),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Exp.', style: TextStyle(color: textColor)),
                  const SizedBox(width: 4),
                  Text(data.expiration, style: TextStyle(color: textColor)),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                data.name,
                style: TextStyle(fontSize: 16.0, color: textColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CreditCardData {
  int index;
  bool locked;
  final String bank;
  final String name;
  final String number;
  final String expiration;
  final String cvc;

  CreditCardData({
    this.index = 0,
    this.locked = false,
    required this.bank,
    required this.name,
    required this.number,
    required this.expiration,
    required this.cvc,
  });

  factory CreditCardData.fromJson(Map<String, dynamic> json) => CreditCardData(
    index: json['index'],
    bank: json['bank'],
    name: json['name'],
    number: json['number'],
    expiration: json['expiration'],
    cvc: json['cvc'],
  );
}

const List<Map<String, dynamic>> kCreditCards = [
  {
    'index': 0,
    'bank': 'Aerarium',
    'name': 'John Doe',
    'number': '5234 4321 1234 4321',
    'expiration': '11/25',
    'cvc': '123',
  },
  {
    'index': 1,
    'bank': 'Aerarium',
    'name': 'John Doe',
    'number': '4234 4321 1234 4321',
    'expiration': '07/24',
    'cvc': '321',
  },
  {
    'index': 2,
    'bank': 'Aerarium',
    'name': 'John Doe',
    'number': '5234 4321 1234 4321',
    'expiration': '09/23',
    'cvc': '456',
  },
];
