import 'package:flutter/material.dart';

class ProgressDialog {
  CircularProgressIndicator circularProgressIndicator;
  BuildContext _context;
  bool isProgressShown = false;

  ProgressDialog(this._context);

  showProgress() {
    showDialog(
        context: _context,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    isProgressShown = true;
  }

  hideProgress() {
    debugPrint("isProgressShown==>"+isProgressShown.toString());
    if (isProgressShown) Navigator.pop(_context);
    isProgressShown = false;
  }
}
