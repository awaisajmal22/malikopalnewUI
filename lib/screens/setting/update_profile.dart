import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:malikopal/ScopedModelWrapper.dart';
import 'package:malikopal/bloc/dash_board_bloc.dart';
import 'package:malikopal/model/UpdateProfileResponse_model.dart';
import 'package:malikopal/model/requestbody/UpdateProfileReqBody_model.dart';
import 'package:malikopal/networking/ApiResponse.dart';
import 'package:malikopal/networking/Endpoints.dart';
import 'package:malikopal/repositories/auth_repo/AuthRepository.dart';
import 'package:malikopal/screens/dashboard/custom.widgets/custom_widgets.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/alerts.dart';
import 'package:malikopal/screens/setting/components/setting.widgets.dart';
import 'package:malikopal/screens/setting/update_bank_details.dart';
import 'package:malikopal/screens/widgets/loading_dialog.dart';
import 'package:malikopal/utils/utility.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../dashboard/dashboard.screens/hidecapital.screen.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView(
      {required this.isProfileUpdate,
      required this.isBankDetailUpdate,
      Key? key})
      : super(key: key);
  static const routeName = '/update-screen';
  final bool isProfileUpdate;
  final bool isBankDetailUpdate;
  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  late TextEditingController _cnicdatetextcontroller;
  late TextEditingController _userNametextcontroller;
  late TextEditingController _fatherNamecontroller;
  late TextEditingController _cnintextcontroller;
  late TextEditingController _emailtextcontroller;
  late TextEditingController _mobileNotextcontroller;
  late TextEditingController _addresstextcontroller;
  late TextEditingController _noktextcontroller;
  late TextEditingController _nokCnictextcontroller;
  late TextEditingController _nokMobileNotextcontroller;
  var maskFormatter = new MaskTextInputFormatter(
      mask: '##-##-####', filter: {"#": RegExp(r'[0-9]')});
  var cnicmaskFormatter = new MaskTextInputFormatter(
      mask: '#####-#######-#',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  // var mobilemaskFormatter = new MaskTextInputFormatter(
  //     mask: '92##########',
  //     filter: {"#": RegExp(r'[0-9]')},
  //     type: MaskAutoCompletionType.lazy);
  var nokcnicmaskFormatter = new MaskTextInputFormatter(
      mask: '#####-#######-#',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  // var nokmobilemaskFormatter = new MaskTextInputFormatter(
  //     mask: '92##########',
  //     filter: {"#": RegExp(r'[0-9]')},
  //     type: MaskAutoCompletionType.lazy);
  final GlobalKey<TooltipState> tooltipkeynokmobile = GlobalKey<TooltipState>();

  final GlobalKey<TooltipState> tooltipkeymobile = GlobalKey<TooltipState>();

  String _selectedGuardianType = '';
  String _selectednokRelation = '';
  late DashBoardBloc _bloc;
  UpdateProfileResponseDataModel? data;
  late UpdateProfileReqDataModel reqData;
  String? selectedImage;
  void pickImage({required ImageSource source}) async {
    XFile? pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      // setState(() {
      // selectedImage = pickedImage.path;
      ImageCrop(pickedImage.path);
      // });
      //_bloc.SaveProfilePic(pickedImage.path);
    }
  }

  void ImageCrop(String filePath) async {
    bool isDark = false;
    ScopedModelDescendant<AppModel>(builder: (BuildContext context, _, model) {
      setState(() {
        isDark = model.isDarkTheme;
      });
      return SizedBox.shrink();
    });
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
            // toolbarTitle: 'Cropper',
            activeControlsWidgetColor: Color(0xFF2A2D2E),
            toolbarColor: Colors.transparent,
            backgroundColor:
                isDark == true ? Color(0xFF2A2D2E) : Color(0xFFF1F1F2),
            toolbarWidgetColor:
                isDark == true ? Color(0xFFF1F1F2) : Color(0xFF2A2D2E),
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedImage != null) {
      setState(() {
        selectedImage = croppedImage.path;
      });
    }
  }

  String FirstReverse(String str) {
    // code goes here
    String word = '';
    for (int i = str.length; i == 0; i++) {
      word = word + str[str.length];
    }

    return word;
  }

  void ShowPicDiallog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
          title: Text("Choose Image from"),
          content: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.h),
                  child: Card(
                    child: GestureDetector(
                      onTap: () {
                        pickImage(source: ImageSource.camera);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Open Camera",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Padding(
                  padding: EdgeInsets.all(8.h),
                  child: Card(
                    child: GestureDetector(
                      onTap: () {
                        pickImage(source: ImageSource.gallery);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Open Gallery",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  @override
  void initState() {
    _bloc = DashBoardBloc();
    //_userIdtextcontroller = TextEditingController(text: data?.userID);

    _userNametextcontroller =
        TextEditingController(text: data?.accountHolderName);
    _fatherNamecontroller = TextEditingController(text: data?.fatherName);
    _cnintextcontroller = TextEditingController(text: data?.accountHolderCNIC);
    _emailtextcontroller = TextEditingController(text: data?.email);
    _mobileNotextcontroller = TextEditingController(text: data?.phoneNumber);

    _addresstextcontroller = TextEditingController(text: data?.address);
    _noktextcontroller = TextEditingController(text: data?.nextOfKinName);
    _nokCnictextcontroller = TextEditingController(text: data?.nextOfKinCNIC);
    _cnicdatetextcontroller = TextEditingController(text: data?.cnicIssuedDate);

    _nokMobileNotextcontroller =
        TextEditingController(text: data?.nextOfKinPhone);

    _bloc.UpdateProfileResponsegetStream.listen((event) {
      if (event.status == Status.COMPLETED) {
        DialogBuilder(context).hideLoader();
        setState(() {
          data = event.data;
        });
        print(jsonEncode(data));
        reqData = UpdateProfileReqDataModel(
            accountHolderCNIC: data?.accountHolderCNIC,
            accountHolderName: data?.accountHolderName,
            address: data?.address,
            email: data?.email,
            fatherName: data?.fatherName,
            guardianType: "father",
            nextOfKinCNIC: data?.nextOfKinCNIC,
            nextOfKinName: data?.nextOfKinName,
            nextOfKinPhone: data?.nextOfKinPhone,
            nextOfKinRelation: data?.nextOfKinRelation,
            phoneNumber: data?.phoneNumber,
            source: AppModel().deviceID());

        _selectednokRelation = data?.nextOfKinRelation ?? "";
        _selectedGuardianType = data?.guardianType ?? "";
        _userNametextcontroller.text = data?.accountHolderName ?? "";
        _fatherNamecontroller.text = data?.fatherName ?? "";
        _cnintextcontroller.text = data?.accountHolderCNIC ?? "";
        _emailtextcontroller.text = data?.email ?? "";
        _mobileNotextcontroller.text = data?.phoneNumber ?? "";
        _addresstextcontroller.text = data?.address ?? "";
        _noktextcontroller.text = data?.nextOfKinName ?? "";
        _nokCnictextcontroller.text = data?.nextOfKinCNIC ?? "";
        _cnicdatetextcontroller.text = data?.cnicIssuedDate ?? "";
        _nokMobileNotextcontroller.text = data?.nextOfKinPhone ?? "";

        maskFormatter = new MaskTextInputFormatter(
            mask: '##-##-####',
            initialText: data?.cnicIssuedDate,
            filter: {"#": RegExp(r'[0-9]')});
        cnicmaskFormatter = new MaskTextInputFormatter(
            mask: '#####-#######-#',
            initialText: data?.accountHolderCNIC,
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy);
        // mobilemaskFormatter = new MaskTextInputFormatter(
        //     mask: '92##########',
        //     initialText: data?.phoneNumber,
        //     filter: {"#": RegExp(r'[0-9]')},
        //     type: MaskAutoCompletionType.lazy);
        nokcnicmaskFormatter = new MaskTextInputFormatter(
            mask: '#####-#######-#',
            initialText: data?.nextOfKinCNIC,
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy);
        // nokmobilemaskFormatter = new MaskTextInputFormatter(
        //     mask: '92##########',
        //     initialText: data?.nextOfKinPhone,
        //     filter: {"#": RegExp(r'[0-9]')},
        //     type: MaskAutoCompletionType.lazy);
      } else if (event.status == Status.ERROR) {
        DialogBuilder(context).hideLoader();
        showSnackBar(context, event.message, true);
      } else if (event.status == Status.LOADING) {
        DialogBuilder(context).showLoader();
      }
    });
    _bloc.GetProfileData();

    _bloc.UpdateProfileResponsepostStream.listen((event) {
      if (event.status == Status.COMPLETED) {
        DialogBuilder(context).hideLoader();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WithDrawPaymentAlert(
                message: "Profile Data Updated successfully"),
          ),
        );
      } else if (event.status == Status.ERROR) {
        DialogBuilder(context).hideLoader();
        //showSnackBar(context, event.message, true);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WithDrawPaymentAlert(message: event.message),
          ),
        );
      } else if (event.status == Status.LOADING) {
        DialogBuilder(context).showLoader();
      }
    });

    super.initState();
  }

  var _formKeyC = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0.h),
          child: ShowUpAnimation(
            delayStart: Duration(milliseconds: 0),
            animationDuration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            direction: Direction.horizontal,
            offset: 0.7.w,
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                CustomTopBar(
                    backButtonColor: isDarkThemeEnabled(context)
                        ? Colors.white
                        : Colors.black,
                    topbartitle: "Update Profile",
                    isProfileUpdate: widget.isProfileUpdate),
                Container(
                  height: MediaQuery.of(context).size.height - 100,
                  child: KeyboardVisibilityBuilder(builder: (context, visible) {
                    //

                    final viewInsets = EdgeInsets.fromWindowPadding(
                        WidgetsBinding.instance.window.viewInsets,
                        WidgetsBinding.instance.window.devicePixelRatio);

                    return Padding(
                      padding: EdgeInsets.only(
                          bottom:
                              visible ? (viewInsets.bottom + 30).h : 12.0.h),
                      child: Form(
                        key: _formKeyC,
                        child: ListView(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                    flex: 1,
                                    child: Container(
                                      height: size.height * 0.2.h,
                                      margin: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: isDarkThemeEnabled(context)
                                                ? Colors.white
                                                : Colors.black,
                                            width: 2.w,
                                          )),
                                      child: GestureDetector(
                                        onTap: () {
                                          ShowPicDiallog();
                                        },
                                        child: selectedImage != null
                                            ? CircleAvatar(
                                                radius: isTablet() ? 100 : 60,
                                                backgroundImage: FileImage(
                                                  File(selectedImage ?? ""),
                                                ),
                                              )
                                            : CircleAvatar(
                                                radius: isTablet() ? 100 : 60,
                                                backgroundImage: NetworkImage(data
                                                            ?.NewImageName ==
                                                        null
                                                    ? (data?.imageUrl == null
                                                        ? Endpoints
                                                            .noProfilePicUrl
                                                        : (Endpoints
                                                                .profilePicUrl +
                                                            (data?.imageUrl ??
                                                                "")))
                                                    : Endpoints
                                                            .profilePicReqUrl +
                                                        (data?.NewImageName ??
                                                            "")),
                                              ),
                                      ),
                                    ))
                              ],
                            ),
                            ProfileListTile(
                              hint: "Full Name",
                              textcontroller: _userNametextcontroller,
                              label: "Full Name",
                              keyboardtype: TextInputType.text,
                              onChanged: (value) {
                                reqData.accountHolderName = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 14.w),
                                decoration: BoxDecoration(

                                    // color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: isDarkThemeEnabled(context)
                                            ? Colors.white
                                            : Colors.black)
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Theme.of(context)
                                    //         .shadowColor
                                    //         .withOpacity(0.3),
                                    //     blurRadius: 4.h,
                                    //     spreadRadius: 3.w,
                                    //     offset: Offset(1.w, 3.h),
                                    //   ),
                                    // ],
                                    ),
                                child: ListTile(
                                    // minVerticalPadding: 10.0.h,
                                    subtitle: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    hint: _selectedGuardianType == ""
                                        ? Text('Guardian Type')
                                        : Text(
                                            _selectedGuardianType,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                    isExpanded: true,
                                    iconSize: 30.0.h,
                                    style: TextStyle(fontSize: 14.sp),
                                    items: data?.guardianTypes.map(
                                      (val) {
                                        return DropdownMenuItem<String>(
                                          value: val,
                                          child: Text(
                                            val,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (val) {
                                      reqData.guardianType = val.toString();
                                      setState(
                                        () {
                                          _selectedGuardianType =
                                              val.toString();
                                        },
                                      );
                                    },
                                  ),
                                )),
                              ),
                            ),
                            ProfileListTile(
                              hint: "Guardian Name",
                              textcontroller: _fatherNamecontroller,
                              label: "Guardian Name",
                              keyboardtype: TextInputType.text,
                              onChanged: (value) {
                                reqData.fatherName = value;
                              },
                              validator: (p0) {
                                if (p0?.isEmpty ?? true) {
                                  return "please enter guardian name";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            ProfileListTile(
                              maskTextInputFormatter: maskFormatter,
                              hint: "CNIC Issue Date",
                              textcontroller: _cnicdatetextcontroller,
                              label: "CNIC Issue Date",
                              keyboardtype: TextInputType.text,
                              onChanged: (value) {
                                reqData.cnicIssuedDate = value;
                              },
                              validator: (p0) {
                                if (p0?.isEmpty ?? false) {
                                  return 'field value should not empty';
                                }
                                return null;
                              },
                              // trailinig: Container(
                              //   child: GestureDetector(
                              //     child: Text('select date'),
                              //     onTap: () {
                              //       showSnackBar(context, 'hello date', false);
                              //     },
                              //   ),
                              // ),
                            ),
                            ProfileListTile(
                              maskTextInputFormatter: cnicmaskFormatter,
                              hint: "CNIC",
                              textcontroller: _cnintextcontroller,
                              label: "CNIC",
                              keyboardtype: TextInputType.text,
                              onChanged: (value) {
                                reqData.accountHolderCNIC = value;
                              },
                              validator: (p0) {
                                if (p0?.isEmpty ?? true) {
                                  return 'field value should not empty';
                                }
                                return null;
                              },
                            ),
                            ProfileListTile(
                              hint: "Email ID",
                              textcontroller: _emailtextcontroller,
                              label: "Email ID",
                              keyboardtype: TextInputType.emailAddress,
                              onChanged: (value) {
                                reqData.email = value;
                              },
                              validator: (p0) {
                                if (p0?.isEmpty ?? false) {
                                  return 'field value should not empty';
                                }
                                return null;
                              },
                            ),
                            ProfileListTile(
                              //maskTextInputFormatter: mobilemaskFormatter,
                              hint: "e.g 92314xxxxx",
                              textcontroller: _mobileNotextcontroller,
                              label: "Mobile",
                              // leading: Text(
                              //   "92",
                              //   style: TextStyle(
                              //       fontSize: 12,
                              //       height: 1,
                              //       color: Colors.black),
                              // ),
                              keyboardtype: TextInputType.phone,
                              onChanged: (value) {
                                reqData.phoneNumber = value;
                              },
                              validator: (p0) {
                                if (p0?.isEmpty ?? false) {
                                  return 'field value should not empty';
                                }

                                if (!p0!.startsWith("92")) {
                                  return "please add 92 in starting of number";
                                }
                                if (p0.length < 10) {
                                  return "enter valid number";
                                }

                                return null;
                              },
                            ),
                            ProfileListTile(
                              hint: "Address",
                              textcontroller: _addresstextcontroller,
                              label: "Address",
                              keyboardtype: TextInputType.multiline,
                              onChanged: (value) {
                                reqData.address = value;
                              },
                              validator: (p0) {
                                if (p0?.isEmpty ?? false) {
                                  return 'field value should not empty';
                                }
                                return null;
                              },
                            ),
                            ProfileListTile(
                              hint: 'Next of Kin',
                              textcontroller: _noktextcontroller,
                              label: "Next of Kin",
                              keyboardtype: TextInputType.text,
                              onChanged: (value) {
                                reqData.nextOfKinName = value;
                              },
                              validator: (p0) {
                                if (p0?.isEmpty ?? false) {
                                  return 'field value should not empty';
                                }
                                return null;
                              },
                            ),
                            ProfileListTile(
                              maskTextInputFormatter: nokcnicmaskFormatter,
                              hint: "Next of Kin CNIC",
                              textcontroller: _nokCnictextcontroller,
                              label: "Next of Kin CNIC",
                              keyboardtype: TextInputType.number,
                              onChanged: (value) {
                                reqData.nextOfKinCNIC = value;
                              },
                              validator: (p0) {
                                if (p0?.isEmpty ?? false) {
                                  return 'field value should not empty';
                                }
                                return null;
                              },
                            ),
                            ProfileListTile(
                              //maskTextInputFormatter: nokmobilemaskFormatter,
                              hint: "Next of Kin Contact Number",
                              textcontroller: _nokMobileNotextcontroller,
                              label: "Next of Kin Contact Number",
                              keyboardtype: TextInputType.phone,
                              onChanged: (value) {
                                reqData.nextOfKinPhone = value;
                              },
                              validator: (p0) {
                                if (p0?.isEmpty ?? false) {
                                  return 'field value should not empty';
                                }

                                if (!p0!.startsWith("92")) {
                                  return "please add 92 in starting of number";
                                }
                                if (p0.length < 10) {
                                  return "enter valid number";
                                }

                                return null;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 14.w),
                                decoration: BoxDecoration(
                                    // color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: isDarkThemeEnabled(context)
                                            ? Colors.white
                                            : Colors.black)
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Theme.of(context)
                                    //         .shadowColor
                                    //         .withOpacity(0.3),
                                    //     blurRadius: 4.h,
                                    //     spreadRadius: 3.w,
                                    //     offset: Offset(1.w, 3.h),
                                    //   ),
                                    // ],
                                    ),
                                child: ListTile(
                                    // minVerticalPadding: 10.0.h,
                                    subtitle: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    hint: _selectednokRelation == ""
                                        ? Text('Relation with Next of Kin')
                                        : Text(
                                            _selectednokRelation,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                    isExpanded: true,
                                    iconSize: 30.0.h,
                                    style: TextStyle(fontSize: 14.sp),
                                    items: data?.nextOfKinRelationList.map(
                                      (val) {
                                        return DropdownMenuItem<String>(
                                          value: val,
                                          child: Text(
                                            val,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (val) {
                                      reqData.nextOfKinRelation =
                                          val.toString();
                                      setState(
                                        () {
                                          _selectednokRelation = val.toString();
                                        },
                                      );
                                    },
                                  ),
                                )),
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: AnimatedLongButton(
                                // GestureDetector(
                                onPressed: () {
                                  if (!_formKeyC.currentState!.validate()) {
                                    showSnackBar(
                                        context,
                                        'Fields can\'t be Empty, Please fill the Fields Correctly',
                                        true);
                                    print('invalid form');
                                    return;
                                  }

                                  if ( //userID == "" ||
                                      reqData.accountHolderName == "" ||
                                          reqData.fatherName == "" ||
                                          reqData.cnicIssuedDate == "" ||
                                          reqData.accountHolderCNIC == "" ||
                                          reqData.email == "" ||
                                          reqData.phoneNumber == "" ||
                                          reqData.address == "" ||
                                          reqData.nextOfKinName == "" ||
                                          reqData.nextOfKinCNIC == "" ||
                                          reqData.nextOfKinPhone == "" ||
                                          _selectednokRelation == "") {
                                    showSnackBar(
                                        context,
                                        'Fields can\'t be Empty, Please fill the Fields Correctly',
                                        true);
                                    return;
                                  }

                                  if (!cnicmaskFormatter.isFill()) {
                                    showSnackBar(
                                        context, 'Invalid CNIC number.', true);
                                    return;
                                  }

                                  if (!maskFormatter.isFill()) {
                                    showSnackBar(context,
                                        'Invalid CNIC Issue date.', true);
                                    return;
                                  }

                                  // if (!mobilemaskFormatter.isFill() ) {
                                  //   showSnackBar(
                                  //       context, 'Invalid contact no.', true);
                                  //   return;
                                  // }
                                  if (!EmailValidator.validate(
                                      reqData.email ?? "")) {
                                    showSnackBar(
                                        context,
                                        'Please enter a valid email address.',
                                        true);
                                    return;
                                  }
                                  // if (!nokmobilemaskFormatter.isFill() ) {
                                  //   showSnackBar(
                                  //       context,
                                  //       'Invalid Next of Kin contact number.',
                                  //       true);
                                  //   return;
                                  // }

                                  if (!nokcnicmaskFormatter.isFill()) {
                                    showSnackBar(
                                        context,
                                        'Invalid Next of Kin CNIC number.',
                                        true);
                                    return;
                                  }

                                  if (!_formKeyC.currentState!.validate()) {
                                    print('invalid form');
                                    return;
                                  } else {
                                    print('valid form');
                                  }
                                  if (widget.isBankDetailUpdate == true &&
                                      widget.isProfileUpdate == true) {
                                    //
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            UpdateBankDetailsView(
                                          bankDetailUpdate:
                                              widget.isBankDetailUpdate,
                                        ),
                                      ),
                                    );
                                  }
                                  if (widget.isProfileUpdate == true &&
                                      widget.isBankDetailUpdate == false) {
                                    Navigator.pushReplacementNamed(
                                        context, HideCapitalView.routeName);
                                  }
                                  _bloc.SaveProfileData(
                                      UpdateProfileReqDataModel(
                                        accountHolderCNIC:
                                            _cnintextcontroller.text,
                                        fatherName: _fatherNamecontroller.text,
                                        guardianType: _selectedGuardianType,
                                        cnicIssuedDate:
                                            _cnicdatetextcontroller.text,
                                        phoneNumber:
                                            _mobileNotextcontroller.text,
                                        email: _emailtextcontroller.text,
                                        address: _addresstextcontroller.text,
                                        nextOfKinName: _noktextcontroller.text,
                                        nextOfKinCNIC:
                                            _nokCnictextcontroller.text,
                                        nextOfKinRelation: _selectednokRelation,
                                        imageUrl: data?.imageUrl,
                                        accountHolderName:
                                            _userNametextcontroller.text,
                                        nextOfKinPhone:
                                            _nokMobileNotextcontroller.text,
                                      ),
                                      selectedImage);
                                  print('Profile Updated');
                                },
                                // child: AnimatedLongButton(
                                text: "Update",
                                fontsize: 16.sp,
                                fontWeight: FontWeight.w700,
                                isBgColorWhite: false,
                                width:
                                    MediaQuery.of(context).size.width * 0.8.w,
                                color: [Color(0xff245180), Color(0xff254180)],
                                // [Color(0xff1164AA), Color(0xff1164AA)],
                              ),
                            ),
                            // ),
                            SizedBox(
                              height: 80.h,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text customlableText({required BuildContext context, required String lable}) {
    return Text(
      lable,
      style: Theme.of(context)
          .textTheme
          .bodyText2!
          .copyWith(color: Color(0xFFF15B28), fontWeight: FontWeight.w400),
    );
  }
}
