import 'package:flutter/material.dart';
import 'package:movieapp/core/constant/const.dart';
import 'package:movieapp/ui/shared/toast/show_toast.dart';

class PopularPersonOriginalImg extends StatefulWidget {
  final String? imgFilePath;
  final VoidCallback? saveImage;
  const PopularPersonOriginalImg({Key? key, this.imgFilePath, this.saveImage})
      : super(key: key);

  @override
  State<PopularPersonOriginalImg> createState() =>
      _PopularPersonOriginalImgState();
}

class _PopularPersonOriginalImgState extends State<PopularPersonOriginalImg> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showToast(message: 'tap twice for exit!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onDoubleTap: () {
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 7.0, vertical: 32.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  child: Image.network(
                      '${Constant.baseUrlImgOriginal}${widget.imgFilePath}'),
                ),
              ),
              TextButton(
                  onPressed: widget.saveImage,
                  child: const Text('ADD TO GALLERY !',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 25.0,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
