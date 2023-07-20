import 'package:flutter/material.dart';

import '../helper/styles.dart';

class UpdateDialog extends StatelessWidget {
  const UpdateDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return Future.value(false);
      },
      child: Center(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
          child: Material(
            child: Container(
              width: width(context)*0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width(context)*0.8,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5))
                    ),
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Text(
                      "New Version Found",
                      style: textStyle(context: context,isBold: true,fontSize: FontSize.H1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      '''
Dear User,

We have noticed that your app is not the latest version. It is essential to update the app to enjoy new features and improvements. Kindly contact the developer to ensure you have the most up-to-date version of the app.
                      ''',
                      style: textStyle(context: context,isBold: false,fontSize: FontSize.H5,color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
