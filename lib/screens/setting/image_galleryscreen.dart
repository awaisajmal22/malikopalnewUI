import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malikopal/model/GalleryResponse_model.dart';
import 'package:malikopal/screens/setting/components/setting.widgets.dart';
import 'package:malikopal/utils/utility.dart';

class ImageGalleryView extends StatefulWidget {
  const ImageGalleryView({Key? key}) : super(key: key);

  @override
  State<ImageGalleryView> createState() => _ImageGalleryViewState();
}

class _ImageGalleryViewState extends State<ImageGalleryView> {
  //List<GalleryResponseData>? data;
  //late DashboardBloc _bloc;

  List<GalleryResponseDataModel>? data = [
    GalleryResponseDataModel(
        id: 1,
        title: "Islamabad Office",
        description: "",
        pined: false,
        images: [
          ImagesModel(id: 1, path: "assets/gallery/isbthumbnail.jpg"),
          ImagesModel(id: 1, path: "assets/gallery/isb1.jpg"),
          ImagesModel(id: 1, path: "assets/gallery/isb2.jpg"),
          ImagesModel(id: 1, path: "assets/gallery/isb3.jpg"),
          ImagesModel(id: 1, path: "assets/gallery/isb4.jpg"),
          ImagesModel(id: 1, path: "assets/gallery/isb5.jpg"),
          ImagesModel(id: 1, path: "assets/gallery/isb6.jpg"),
          ImagesModel(id: 1, path: "assets/gallery/isb7.jpg"),
          ImagesModel(id: 1, path: "assets/gallery/isb8.jpg"),
          ImagesModel(id: 1, path: "assets/gallery/isb9.jpg"),
          ImagesModel(id: 1, path: "assets/gallery/isb10.jpg"),
          ImagesModel(id: 1, path: "assets/gallery/isb11.jpg"),
          ImagesModel(id: 1, path: "assets/gallery/isb12.jpg"),
          ImagesModel(id: 1, path: "assets/gallery/isb13.jpg"),
          ImagesModel(id: 1, path: "assets/gallery/isb14.jpg"),
          ImagesModel(id: 1, path: "assets/gallery/isb15.jpg"),
          ImagesModel(id: 1, path: "assets/gallery/isb16.jpg"),
          ImagesModel(id: 1, path: "assets/gallery/isb17.jpg"),
          ImagesModel(id: 1, path: "assets/gallery/isb18.jpg"),
        ]),
    GalleryResponseDataModel(
        id: 1,
        title: "Dubai Office",
        description: "",
        pined: false,
        images: [
          ImagesModel(id: 1, path: "assets/gallery/dubthumbnail.jpg"),
          ImagesModel(id: 1, path: "assets/gallery/dub1.jpg"),
          ImagesModel(id: 1, path: "assets/gallery/dub2.jpg"),
          ImagesModel(id: 1, path: "assets/gallery/dub3.jpg"),
        ]),

    //   id: 1,
    //    title: "US Office",
    //   description: "",
    //    pined: false,
    //  images: [
    //    Images(id: 1, path: "assets/gallery/usthumbail.jpg"),
    //   Images(id: 1, path: "assets/gallery/us1.png"),
    //   Images(id: 1, path: "assets/gallery/us2.png"),
    // ])
  ];

  int i = 0;
  @override
  void initState() {
    //_bloc = DashboardBloc();

    // _bloc.GalleryStream.listen((event) {
    //   if (event.status == Status.COMPLETED) {
    //     DialogBuilder(context).hideLoader();
    //     setState(() {
    //       data = event.data;
    //       print(data);
    //     });
    //   } else if (event.status == Status.ERROR) {
    //     DialogBuilder(context).hideLoader();
    //     showSnackBar(context, event.message, true);
    //   } else if (event.status == Status.LOADING) {
    //     DialogBuilder(context).showLoader();
    //   }
    // });
    // _bloc.getGalleryData();

    super.initState();
  }

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            CustomTopBar(
                backButtonColor:
                    isDarkThemeEnabled(context) ? Colors.white : Colors.black,
                topbartitle: 'Image Gallery'),
            Container(
              height: isTablet() ? size.height * 1.2 : size.height * 1.0,
              child: Column(
                // shrinkWrap: true,
                // physics: const BouncingScrollPhysics(),
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: size.height * 0.15.h,
                    // width: size.width * 0.87.w,
                    margin: const EdgeInsets.symmetric(horizontal: 18.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            // Color(0xFF4C7A45),
                            // Color(0xFF59F803),
                            // Color(0xff254180),
                            // Color(0xff254180)
                            Color(0xffACBBF3),
                            Color(0xffACBBF3),
                            // Color(0xff1164AA),
                            // Color(0xff1164AA)
                          ]),
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).shadowColor,
                            spreadRadius: 0.33.w,
                            blurRadius: 3.h,
                            offset: Offset(2.w, 4.h)),
                      ],
                    ),
                    child: Text(
                      "Every Picture Tells a Story",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.black,
                          //  Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 18.0.w, top: 28.h, bottom: 24.h),
                    child: Container(
                        width: double.maxFinite,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Text("Categories",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                              height: isTablet()
                                  ? size.height * 0.11.h
                                  : size.height * 0.18.h,
                              width: double.maxFinite,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: data?.length ?? 0,
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selected = index;
                                      });
                                      print(data?[index].images?[0].path);
                                    },
                                    child: CustomHorizontalListView(
                                      title: data?[index].title ?? "",
                                      child: AssetImage(
                                          'assets/gallery/noimg.png'),
                                      Imagepath:
                                          data?[index].images?[0].path ?? "",
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 12.w, right: 18.w, top: 10.h),
                    child: Container(
                      height: size.height * 0.45.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: data?[selected].images?.length,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (index == 0) return Container();
                            return Row(
                              children: [
                                Container(
                                  width: size.width * 0.8,
                                  height: size.height,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).backgroundColor),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6.0, vertical: 6.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child:
                                          // (data?[selected]
                                          //                 .images?[index]
                                          //                 .path ??
                                          //             "")
                                          //         .isNotEmpty
                                          //     ? Image.network(
                                          //         Endpoints.GetGalleryUrl(
                                          //             data?[selected]
                                          //                     .images?[index]
                                          //                     .path ??
                                          //                 ""))
                                          //     :
                                          Image.asset(
                                        data?[selected].images?[index].path ??
                                            'assets/gallery/noimg.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
                  // SizedBox(
                  //   height: 80.h,
                  // ),
                  // AnimatedBottomBar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class imageViewer extends StatefulWidget {
  imageViewer({
    Key? key,
    this.imagepath,
  }) : super(key: key);

  final String? imagepath;

  @override
  State<imageViewer> createState() => _imageViewerState();
}

class _imageViewerState extends State<imageViewer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Received Image ---->:$widget.imagepath");
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(left: 12.w, right: 18.w, top: 10.h),
      child: Container(
        height: size.height * 0.35.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 14,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                    width: size.width * 0.8,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 06),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          // widget.imagepath ?? "",
                          // height: size.height * 0.2,
                          'assets/gallery/h.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 06),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          // widget.imagepath ?? "",
                          // height: size.height * 0.2,
                          'assets/gallery/aa.png',

                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 06),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          // widget.imagepath ?? "",
                          // height: size.height * 0.2,
                          'assets/gallery/b.png',

                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 06),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          // widget.imagepath ?? "",
                          // height: size.height * 0.2,
                          'assets/gallery/c.png',

                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 06),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          // widget.imagepath ?? "",
                          // height: size.height * 0.2,
                          'assets/gallery/d.png',

                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 06),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          // widget.imagepath ?? "",
                          // height: size.height * 0.2,
                          'assets/gallery/e.png',

                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 06),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          // widget.imagepath ?? "",
                          // height: size.height * 0.2,
                          'assets/gallery/ef.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 06),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          // widget.imagepath ?? "",
                          // height: size.height * 0.2,
                          'assets/gallery/f.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 06),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          // widget.imagepath ?? "",
                          // height: size.height * 0.2,
                          'assets/gallery/g.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 06),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          // widget.imagepath ?? "",
                          // height: size.height * 0.2,
                          'assets/gallery/a.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 06),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          // widget.imagepath ?? "",
                          // height: size.height * 0.2,
                          'assets/gallery/i.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 06),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          // widget.imagepath ?? "",
                          // height: size.height * 0.2,
                          'assets/gallery/t.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 06),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          // widget.imagepath ?? "",
                          // height: size.height * 0.2,
                          'assets/gallery/two.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
