import 'package:flutter/material.dart';
import 'package:fastinvoice/styles/text_styles.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final Function(int) onItemTapped;

  const BottomNavigationBarWidget({Key? key, required this.onItemTapped}) : super(key: key);

  @override
  BottomNavigationBarWidgetState createState() => BottomNavigationBarWidgetState();
}

class BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(20),
      height: size.width * .155,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: ListView.builder(
        itemCount: listOfIcons.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: size.width * .024),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
            widget.onItemTapped(index);
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 1500),
                curve: Curves.fastLinearToSlowEaseIn,
                margin: EdgeInsets.only(
                  bottom: index == _selectedIndex ? 0 : size.width * .029,
                  right: size.width * .0422 * (4 / 3),
                  left: size.width * .0422 * (4 / 3),
                ),
                width: size.width * .128 * (4 / 3),
                height:
                    index == _selectedIndex ? size.width * .014 : 0,
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10)),
                ),
              ),
              Icon(
                listOfIcons[index],
                size: size.width * .06,
                color:
                    index == _selectedIndex ? Colors.blueAccent : Colors.black38,
              ),
              SizedBox(height:size.width*.01),
              Text(
                listOfLabels[index],
                style:
                    AppTextStyles.bottomNavigationBarLabel.copyWith(color:
                        index == _selectedIndex ? Colors.blueAccent : Colors.black38),
              ),
              SizedBox(height:size.width*.02)
            ],
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.attach_money_rounded,
    Icons.person_rounded,
  ];
  
  List<String> listOfLabels = [
    'Inicio',
    'Facturas',
    'Perfil',
  ];
}
