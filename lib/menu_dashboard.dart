import 'package:flutter/material.dart';

final TextStyle menuFontStyle = TextStyle(color: Colors.white, fontSize: 20);
final Color backgroundColor = Color(0xFF343442);

class MenuDashboard extends StatefulWidget {
  @override
  _MenuDashboardState createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard>
    with SingleTickerProviderStateMixin {
  double screenHeight, screenWidth;
  bool isMenuOpen = false;
  AnimationController _animationController;
  Animation<double> _scaleAnimation;
  Animation<double> _scaleMenuFontAnimation;
  Animation<Offset> _menuOffSetAnimation;
  Duration _duration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _duration);
    _scaleAnimation = Tween(begin: 1.0, end: 0.7).animate(_animationController);
    _scaleMenuFontAnimation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _menuOffSetAnimation = Tween(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            createMenu(context),
            createDashboard(context),
          ],
        ),
      ),
    );
  }

  createMenu(BuildContext context) {
    return SlideTransition(
      position: _menuOffSetAnimation,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: ScaleTransition(
          scale: _scaleMenuFontAnimation,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                FlatButton.icon(
                  onPressed: null,
                  icon: Icon(
                    Icons.restaurant_menu,
                    color: Colors.purple,
                  ),
                  label: Text(
                    "Dashboard",
                    style: menuFontStyle,
                  ),
                ),
                FlatButton.icon(
                  onPressed: null,
                  icon: Icon(
                    Icons.message,
                    color: Colors.purple,
                  ),
                  label: Text(
                    "Messages",
                    style: menuFontStyle,
                  ),
                ),
                FlatButton.icon(
                  onPressed: null,
                  icon: Icon(
                    Icons.accessibility_new,
                    color: Colors.purple,
                  ),
                  label: Text(
                    "Utility Bills",
                    style: menuFontStyle,
                  ),
                ),
                FlatButton.icon(
                  onPressed: null,
                  icon: Icon(
                    Icons.transform,
                    color: Colors.purple,
                  ),
                  label: Text(
                    "Funds Transfer",
                    style: menuFontStyle,
                  ),
                ),
                FlatButton.icon(
                  onPressed: null,
                  icon: Icon(
                    Icons.build,
                    color: Colors.purple,
                  ),
                  label: Text(
                    "Branches",
                    style: menuFontStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  createDashboard(BuildContext context) {
    return AnimatedPositioned(
      //  top: isMenuOpen ? screenHeight * 0.1 : 0,
      //  bottom: isMenuOpen ? screenHeight * 0.1 : 0,
      top: 0,
      bottom: 0,
      duration: _duration,
      left: isMenuOpen ? 0.4 * screenWidth : 0,
      right: isMenuOpen ? -0.4 * screenWidth : 0,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          borderRadius:
              isMenuOpen ? BorderRadius.circular(40) : BorderRadius.circular(0),
          elevation: 8,
          color: backgroundColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(left: 16.0, right: 16, top: 8),
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.menu),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            isMenuOpen
                                ? _animationController.reverse()
                                : _animationController.forward();
                            isMenuOpen = !isMenuOpen;
                          });
                        },
                      ),
                      Text(
                        "My Cards",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                      )
                    ],
                  ),
                  Container(
                    height: 500,
                    margin: EdgeInsets.only(top: 10),
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          color: Colors.pink,
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        Container(
                          color: Colors.deepPurple,
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        Container(
                          color: Colors.deepOrange,
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView.separated(
                    physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context,index){
                    return ListTile(leading: Icon(Icons.person),
                      title: Text("# $index"),
                      trailing: Icon(Icons.add_circle),
                    );
                  }, separatorBuilder: (context,index){
                    return Divider();
                  }, itemCount: 50)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
