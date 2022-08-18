import 'package:carbon_icons/carbon_icons.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_connect_mongdb/screens/widgets/textFormField.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/subjects.dart';

class RequestForVerifyUserScreen extends StatefulWidget {
  const RequestForVerifyUserScreen({Key? key}) : super(key: key);

  @override
  State<RequestForVerifyUserScreen> createState() =>
      _RequestForVerifyUserScreenState();
}

class _RequestForVerifyUserScreenState
    extends State<RequestForVerifyUserScreen> {
  bool isClickedChoose = false;
  String verifyLogoPath = 'assets/logo/user.png';
  // int onSelectedIndexItemVerify = 0;
  List<String> verifyItems = [
    'Real Estate Agency',
    'Real Estate Developer',
    'Real Estate Company'
  ];
  BehaviorSubject<String> subjectVerifyItem = BehaviorSubject<String>();
  final formKey = GlobalKey<FormState>();
  BehaviorSubject<bool> subjectValidateForm = BehaviorSubject<bool>();

  @override
  void dispose() {
    super.dispose();
  }

  void showDailog(Widget child) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 250,
            padding: EdgeInsets.only(top: 0),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: SafeArea(
              top: false,
              child: child,
            ),
          );
        });
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneNumberFocus = FocusNode();

  BehaviorSubject<List<XFile>> subjectImagesIDcardOrPassport =
      BehaviorSubject<List<XFile>>();
  final ImagePicker picker = ImagePicker();
  //List<XFile> image = [];
  void selectImageIDcardOrPassport() async {
    final List<XFile>? selectedImagesIDcardOrPassport =
        await picker.pickMultiImage();
    if (selectedImagesIDcardOrPassport!.isNotEmpty) {
      //image.addAll(selctedImages);
      subjectImagesIDcardOrPassport.add(selectedImagesIDcardOrPassport);
    }
    print('image list lenght :' +
        selectedImagesIDcardOrPassport.length.toString());
  }

  BehaviorSubject<List<XFile>> subjectImagesCirtificate =
      BehaviorSubject<List<XFile>>();
  void selectImageCirtificate() async {
    final List<XFile>? selectedImages = await picker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      subjectImagesCirtificate.add(selectedImages);
    }
    print('image list lenght :' + selectedImages.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        firstNameFocus.unfocus();
        lastNameFocus.unfocus();
        emailFocus.unfocus();
        phoneNumberFocus.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: [
              StreamBuilder<bool>(
                  initialData: false,
                  stream: subjectValidateForm,
                  builder: (context, AsyncSnapshot snapshot) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 11),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20.0),
                        onTap: snapshot.data == false
                            ? null
                            : () {
                                Navigator.pop(context);
                              },
                        child: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 234, 234, 234),
                          child: Icon(
                            CarbonIcons.close,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  })
            ],
            title: const Text(
              'Request for Verify User',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )),
        backgroundColor: Colors.white,
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            //sized box
            child: Container(height: 20),
          ),
          SliverToBoxAdapter(
            child: buildForm(size),
          )
        ]),
      ),
    );
  }

  Widget buildForm(Size size) {
    return Form(
        key: formKey,
        onChanged: () {
          bool isValidForm =
              formKey.currentState!.validate() && isClickedChoose == true;
          print(isValidForm);
          subjectValidateForm.add(isValidForm);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    color: Color.fromARGB(255, 255, 246, 246)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              //color: Colors.green,
                              image: DecorationImage(
                                  image: AssetImage(verifyLogoPath))),
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //title
                              Text(
                                'Choose position for verify',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              StreamBuilder<String>(
                                  stream: subjectVerifyItem,
                                  initialData: "Choose to become",
                                  builder: (context, AsyncSnapshot snapshot) {
                                    return Text(
                                      snapshot.data,
                                      style: TextStyle(color: Colors.green),
                                    );
                                  }),
                            ]),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                        (states) => const Color(0xffb30000))),
                            onPressed: () {
                              subjectVerifyItem.add(verifyItems[0]);
                              showDailog(CupertinoPicker(
                                  itemExtent: 30,
                                  magnification: 1.2,
                                  diameterRatio: 1.0,
                                  squeeze: 1.0,
                                  useMagnifier: true,
                                  onSelectedItemChanged: (int selectedIndex) {
                                    subjectVerifyItem
                                        .add(verifyItems[selectedIndex]);
                                  },
                                  children: List<Widget>.generate(
                                      verifyItems.length,
                                      (index) => Text(verifyItems[index]))));

                              isClickedChoose = true;
                            },
                            child: const Text('choose'))
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 20),
                child: titleInputForm('Real name'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: 90,
                      width: size.width * 0.45,
                      child: CustomTextFormField(
                        hintText: 'first name or family name',
                        controller: firstNameController,
                        focusNode: firstNameFocus,
                        maxLines: 1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'inser first name';
                          }
                          return null;
                        },
                      )),
                  SizedBox(
                      height: 90,
                      width: size.width * 0.45,
                      child: CustomTextFormField(
                        controller: lastNameController,
                        focusNode: lastNameFocus,
                        hintText: 'last name',
                        maxLines: 1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'inser last name';
                          }
                          return null;
                        },
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 20),
                child: titleInputForm('Email'),
              ),
              SizedBox(
                  height: 90,
                  width: size.width,
                  child: CustomTextFormField(
                    textInputType: TextInputType.emailAddress,
                    controller: emailController,
                    focusNode: emailFocus,
                    hintText: 'sample@mail.com',
                    maxLines: 1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'insert email';
                      }
                      return null;
                    },
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 20),
                child: titleInputForm('Phone number'),
              ),
              SizedBox(
                  height: 90,
                  width: size.width,
                  child: CustomTextFormField(
                    textInputType: TextInputType.number,
                    controller: phoneNumberController,
                    focusNode: phoneNumberFocus,
                    hintText: '+855 ',
                    maxLines: 1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'insert phone number';
                      }
                      return null;
                    },
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 20),
                child: titleInputForm('ID card or Passport'),
              ),
              StreamBuilder<List<XFile>>(
                  stream: subjectImagesIDcardOrPassport,
                  initialData: const <XFile>[],
                  builder: (context, AsyncSnapshot snapshot) {
                    List<XFile> imageSnapshot = snapshot.data;
                    return Container(
                        //id card
                        height: imageSnapshot.isEmpty ? 150 : 180,
                        child: imageSnapshot.isEmpty
                            ? buildPickIDcardOrPassportImage()
                            : buildShowListViewImageIDcardOrPassport(
                                imageSnapshot, size));
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 20),
                child: titleInputForm('Certificate or documents'),
              ),
              StreamBuilder<List<XFile>>(
                  stream: subjectImagesCirtificate,
                  initialData: const <XFile>[],
                  builder: (context, AsyncSnapshot snapshot) {
                    List<XFile> imageSnapshotCirtificate = snapshot.data;
                    return Container(
                        //document
                        height: imageSnapshotCirtificate.isEmpty ? 150 : 180,
                        child: snapshot.data.isNotEmpty
                            ? buildShowListViewImageCirtificate(snapshot, size)
                            : buildPickCirtificateImage());
                  })
            ],
          ),
        ));
  }

  ListView buildShowListViewImageCirtificate(
      AsyncSnapshot<dynamic> snapshot, Size size) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Stack(
            children: [
              Container(
                width: size.width * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(snapshot.data[index].path))),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    snapshot.data.removeAt(index);
                    subjectImagesCirtificate.add(snapshot.data);
                  },
                  child: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 222, 222, 222),
                      child: Icon(
                        CarbonIcons.close,
                        color: Colors.black,
                      )),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  InkWell buildPickCirtificateImage() {
    return InkWell(
      onTap: () {
        selectImageCirtificate();
      },
      child: DottedBorder(
        color: Colors.grey,
        borderType: BorderType.RRect,
        dashPattern: const [6, 3],
        strokeWidth: 2.0,
        radius: const Radius.circular(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Upload',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 5,
              ),
              Icon(
                CarbonIcons.upload,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell buildPickIDcardOrPassportImage() {
    return InkWell(
      onTap: () {
        selectImageIDcardOrPassport();
      },
      child: DottedBorder(
        color: Colors.grey,
        borderType: BorderType.RRect,
        dashPattern: const [6, 3],
        strokeWidth: 2.0,
        radius: const Radius.circular(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Upload',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 5,
              ),
              Icon(
                CarbonIcons.upload,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView buildShowListViewImageIDcardOrPassport(
      List<XFile> imageSnapshot, Size size) {
    return ListView.builder(
      itemCount: imageSnapshot.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Stack(
            children: [
              Container(
                width: size.width * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(imageSnapshot[index].path))),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    imageSnapshot.removeAt(index);
                    subjectImagesIDcardOrPassport.add(imageSnapshot);
                  },
                  child: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 222, 222, 222),
                      child: Icon(
                        CarbonIcons.close,
                        color: Colors.black,
                      )),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Text titleInputForm(String value) => Text(
        value,
        style: const TextStyle(fontSize: 18, color: Colors.black
            //color: Color.fromARGB(255, 127, 127, 127)

            ),
      );
}
