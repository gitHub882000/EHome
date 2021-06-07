import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchBar({
    Key key,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This size provides us total height and width of our screen
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: size.width * 0.9,
      height: size.height * 0.06,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        onChanged: onChanged,
        cursorColor: Theme.of(context).accentColor,
        style: TextStyle(
          color: Theme.of(context).accentColor,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).accentColor,
            size: size.height * 0.03,
          ),
          hintText: 'Search',
          hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w400,
                letterSpacing: 2,
              ),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Theme.of(context).cardColor,
            ),
          ),
        ),
      ),
    );
  }
}
