import 'dart:io';

import 'package:carbon_icons/carbon_icons.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_connect_mongdb/screens/widgets/textFormField.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

class RequestPropertyTypeScreen extends StatefulWidget {
  const RequestPropertyTypeScreen({Key? key}) : super(key: key);

  @override
  State<RequestPropertyTypeScreen> createState() =>
      _RequestPropertyTypeScreenState();
}

class _RequestPropertyTypeScreenState extends State<RequestPropertyTypeScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  FocusNode nameFocus = FocusNode();
  FocusNode reasonFocus = FocusNode();
  FocusNode discriptionFocus = FocusNode();
  bool isValidRequestButton = false;
  BehaviorSubject<bool> subjectRequestButton = BehaviorSubject<bool>();

  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nameFocus.unfocus();
        reasonFocus.unfocus();
        discriptionFocus.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 11),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () {
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
              ),
            ],
            title: const Text(
              'Request for PropertyType',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            )),
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(left: 11, top: 30, bottom: 10),
                child: titleInputForm('Logo'),
              ),
              Container(
                height: 150,
                child: ListView.builder(
                  itemCount: 1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 100,
                        child: InkWell(
                          onTap: () {
                            pickImage();
                          },
                          child: image != null
                              ? Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(image!)),
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: CircleAvatar(
                                          backgroundColor: Color.fromARGB(
                                              255, 222, 222, 222),
                                          child: Icon(
                                            CarbonIcons.camera,
                                            color: Colors.black,
                                          )),
                                    )
                                  ],
                                )
                              : DottedBorder(
                                  color: Colors.grey,
                                  //color: const Color(0xffb30000),
                                  borderType: BorderType.RRect,
                                  dashPattern: const [6, 3],
                                  strokeWidth: 2.0,
                                  radius: const Radius.circular(10.0),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Upload',
                                          style: TextStyle(
                                              color: Colors.black,
                                              // color: Color(
                                              //   0xffb30000,
                                              // ),
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Icon(
                                          CarbonIcons.upload,
                                          color: Colors.black,
                                          //color: Color(0xffb30000),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]),
          ),
          SliverToBoxAdapter(
            child: buildForm(context),
          )
        ]),
      ),
    );
  }

  Form buildForm(BuildContext context) {
    return Form(
      key: formKey,
      onChanged: () {
        if (formKey.currentState!.validate()) {
          isValidRequestButton = true;
          subjectRequestButton.add(isValidRequestButton);
        } else {
          isValidRequestButton = false;
          subjectRequestButton.add(isValidRequestButton);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 11, top: 20, right: 11),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          titleInputForm('Property name'),
          const SizedBox(
            height: 10,
          ),
          buildNameTextFormField(),
          const SizedBox(
            height: 20,
          ),
          titleInputForm('reason'),
          const SizedBox(
            height: 10,
          ),
          buildReasonTextFormField(),
          const SizedBox(
            height: 20,
          ),
          titleInputForm('description (optional)'),
          const SizedBox(
            height: 10,
          ),
          buildDescriptionTextField(),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Color(0xffb30000)),
                ),
              ),
              buildRequestNowButton(),
            ],
          )
        ]),
      ),
    );
  }

  CustomTextFormField buildNameTextFormField() {
    return CustomTextFormField(
        hintText: 'Name',
        focusNode: nameFocus,
        controller: nameController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'please input name';
          }
          return null;
        },
        maxLines: 1);
  }

  CustomTextFormField buildReasonTextFormField() {
    return CustomTextFormField(
        hintText: 'Reason',
        focusNode: reasonFocus,
        controller: reasonController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'please input reason here';
          }
          return null;
        },
        maxLines: 3);
  }

  CustomTextFormField buildDescriptionTextField() {
    return CustomTextFormField(
      hintText: 'Description',
      controller: discriptionController,
      focusNode: discriptionFocus,
      maxLines: 5,
      validator: (String? value) {},
    );
  }

  StreamBuilder<bool> buildRequestNowButton() {
    return StreamBuilder<bool>(
        initialData: false,
        stream: subjectRequestButton,
        builder: (context, AsyncSnapshot snapshot) {
          return ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) =>
                      snapshot.data ? Color(0xffb30000) : Colors.grey)),
              onPressed: snapshot.data ? () {} : null,
              child: Text(
                'Request now',
                style: TextStyle(
                    color: snapshot.data ? Colors.white : Colors.white),
              ));
        });
  }

  Text titleInputForm(String value) => Text(
        value,
        style: const TextStyle(fontSize: 18, color: Colors.black
            //color: Color.fromARGB(255, 127, 127, 127)

            ),
      );
}
