import 'package:flutter/material.dart';
import 'package:YDS/admin/utils/space.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import '../controller/admin_login_controller.dart';

textFieldErrorBorder(bool hasError, AdminLoginController alController,
        BuildContext context) =>
    OutlineInputBorder(
        borderSide: BorderSide(
      color: hasError
          ? Colors.red
          : alController.isLightTheme.value
              ? Theme.of(context).dividerColor
              : Colors.grey.shade100,
    ));

class CreateButton extends StatelessWidget {
  const CreateButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Icon(
            Icons.add,
            color: Colors.white,
          ),
          horizontalSpace(v: 15),
          Text(
            title,
            style: textTheme.displayMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ]),
      ),
    );
  }
}

dropDownBorder() => const OutlineInputBorder(
        borderSide: BorderSide(
      color: Colors.black,
    ));

// ignore: must_be_immutable
class FirebaseSnapHelper<T> extends StatelessWidget {
  FirebaseSnapHelper({
    super.key,
    required this.future,
    required this.onSuccess,
    this.onLoading,
  });

  Future<T> future;
  Function(T) onSuccess;
  Function()? onLoading;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
        future: future,
        builder: (context, AsyncSnapshot<T> snap) {
          if (snap.hasError) {
            debugPrint("Something was wrong");
            return ErrorWidget("Something was wrong!");
          }
          if (snap.hasData) {
            return onSuccess(snap.data!);
          }
          return onLoading == null
              ? SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                )
              : onLoading!();
        });
  }
}

Widget loadingWidget() => Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(),
      ),
    );
Widget onLoading() => SizedBox(
      height: 50,
      width: 200,
      child: Center(
          child: SizedBox(width: 50, child: CircularProgressIndicator())),
    );

Widget getPayType(bool payTypeBool) {
  return Container(
    height: 50,
    width: 100,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      color: payTypeBool ? Colors.green : Colors.amber,
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    child: Text(
      payTypeBool ? "Prepay" : "Cash on",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}

Widget rowWidget(
    {required String left, required Widget right, required double width}) {
  return SizedBox(
    height: 50,
    width: width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          left,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const Expanded(child: SizedBox()),
        right,
      ],
    ),
  );
}

Widget rowText(
    {required String left, required String right, required double width}) {
  return SizedBox(
    height: 50,
    width: width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          left,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const Expanded(child: SizedBox()),
        Text(
          right,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: 22,
          ),
        ),
      ],
    ),
  );
}

Widget photoViewer({required String heroTags}) {
  return Center(
    child: AspectRatio(
      aspectRatio: 16 / 9,
      child: PhotoView(
        imageProvider: NetworkImage(heroTags),
        loadingBuilder: (context, progress) => Center(
          child: Container(
            width: 20.0,
            height: 20.0,
            child: const CircularProgressIndicator(),
          ),
        ),
        backgroundDecoration: BoxDecoration(color: Colors.white.withOpacity(0)),
        gaplessPlayback: false,
        //customSize: MediaQuery.of(context).size,
        heroAttributes: PhotoViewHeroAttributes(
          tag: heroTags,
          transitionOnUserGestures: true,
        ),
        //scaleStateChangedCallback: this.onScaleStateChanged,
        enableRotation: true,
        //controller:  controller,
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 3,
        initialScale: PhotoViewComputedScale.contained,
        basePosition: Alignment.center,
        //scaleStateCycle: scaleStateCycle
      ),
    ),
  );
}

Widget bankSlipImageWidget(String? imageURL, BuildContext context) {
  if (imageURL == null) {
    return const SizedBox();
  }
  return InkWell(
    onTap: () {
      showDialog(
        //barrierColor: Colors.white.withOpacity(0),
        context: Get.context!,
        builder: (context) {
          return photoViewer(heroTags: imageURL);
        },
      );
    },
    child: CachedNetworkImage(
      imageUrl: imageURL,
      width: 50,
      height: 100,
      fit: BoxFit.fill,
      progressIndicatorBuilder: (context, url, status) {
        return Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              value: status.progress,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) => const Icon(Icons.error),
    ),
  );
}
