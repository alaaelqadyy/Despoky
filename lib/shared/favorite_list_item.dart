import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../controllers/service_controller.dart';
import '../models/add_to_favorite.dart';

class FavoriteListItem extends StatefulWidget {
  final FavoriteProduct favoriteItem;

  const FavoriteListItem({Key? key, required this.favoriteItem})
      : super(key: key);

  @override
  _FavoriteListItemState createState() => _FavoriteListItemState();
}

class _FavoriteListItemState extends State<FavoriteListItem> {
  late ServiceController _productService;
  List<FavoriteProduct> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    _productService =
        ServiceController(context); // Initialize the service controller
  }

  Future<void> removeFromFavorites() async {
    try {
      await _productService.removeFromFavorites(
        _productService.authController.getCurrentUser()!.uid,
        widget.favoriteItem.id,
      );
     // setState(() {
        // Remove the item from the list
      //  favoriteItems.removeWhere((item) => item.id == widget.favoriteItem.id);
     // });

    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(error.toString()),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 21.h,
      child: Card(
        elevation: 20,
        color: const Color(0xFF171725),
        child: Row(
          children: [
            Container(
              color: Colors.white,
              child: Image.asset(
                widget.favoriteItem.image,
                width: 35.w,
                height: 40.w,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ' ${widget.favoriteItem.title}',
                        style: GoogleFonts.tenorSans(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 17.sp,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: removeFromFavorites,
                        // Call the remove function
                        icon: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: (3.h),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 3.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.favoriteItem.description}',
                          style: GoogleFonts.tenorSans(
                            textStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                            ),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Size : ${widget.favoriteItem.size}',
                          style: GoogleFonts.tenorSans(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          "  ${widget.favoriteItem.price} \$",
                          style: GoogleFonts.tenorSans(
                            textStyle:
                                TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.sp
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
