import 'package:booksharing/core/viewModels/book_provider/bookModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  OverlayEntry _overlayEntry;
  int choiceChipSelection = 0;

  OverlayEntry showOverlay(context) {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    return OverlayEntry(
      builder: (context) => Positioned(
        // left: offset.dx,
        // top: offset.dy + size.height + 5.0,
        width: size.width,
        child: Material(
          elevation: 4.0,
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                title: Text('Syria'),
                onTap: () {
                  print('Syria Tapped');
                },
              ),
              ListTile(
                title: Text('Lebanon'),
                onTap: () {
                  // _overlayEntry = _createOverlayEntry(context);
                  // Overlay.of(context).();
                  _overlayEntry.remove();
                  print('Lebanon Tapped');
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final BookModel _bookModel = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: ChoiceChip(
              label: Container(
                child: Text(
                  "All",
                  textAlign: TextAlign.center,
                ),
                width: double.infinity,
              ),
              selected: _bookModel.choiceChipSelection == 0,
              selectedColor: Colors.teal[200],
              onSelected: (value) {
                // setState(() {
                _bookModel.changeChoiceChip(value, 0);
                // _bookModel.choiceChipSelection = value ? 0 : -1;
                // });
              },
            ),
          ),
          Expanded(
            child: ChoiceChip(
              label: Text("Free-150"),
              selected: _bookModel.choiceChipSelection == 1,
              selectedColor: Colors.teal[200],
              onSelected: (value) {
                // setState(() {
                _bookModel.changeChoiceChip(value, 1);
                // _bookModel.choiceChipSelection = value ? 1 : -1;
                // });
              },
            ),
          ),
          Expanded(
            child: ChoiceChip(
              label: Text("150-500"),
              selected: _bookModel.choiceChipSelection == 2,
              selectedColor: Colors.teal[200],
              onSelected: (value) {
                // setState(() {
                // choiceChipSelection = value ? 2 : -1;
                _bookModel.changeChoiceChip(value, 2);
                // });
              },
            ),
          ),
          Expanded(
            child: ChoiceChip(
              label: Text("500 & more"),
              selected: _bookModel.choiceChipSelection == 3,
              selectedColor: Colors.teal[200],
              onSelected: (value) {
                // setState(() {
                // choiceChipSelection = value ? 3 : -1;
                _bookModel.changeChoiceChip(value, 3);
                // });
              },
            ),
          ),
        ],
      ),
    );
  }
}
