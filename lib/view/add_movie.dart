import 'package:desktopapp/constant/app_const.dart';
import 'package:desktopapp/model/form_model.dart';
import 'package:desktopapp/widget/button.dart';
import 'package:desktopapp/widget/text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/color.dart';
import '../controller/add_movie_controller.dart';

class AddMoviePage extends StatefulWidget {
  const AddMoviePage({Key? key}) : super(key: key);

  @override
  State<AddMoviePage> createState() => _AddMoviePageState();
}

class _AddMoviePageState extends State<AddMoviePage> {
  final controller = Get.put(AddMovie());

  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      super.dispose();
      controller.dispose();
    }

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Center(
              child: Form(
                  key: controller.firstFormkey,
                  child: SizedBox(
                    height: 520,
                    width: 320,
                    child: ListView(
                      children: [
                        const SizedBox(height: 15),
                        textFieldLabel(AppConst.name),
                        FormWidget(
                          formmodel: FormModel(
                            enableText: false,
                            controller: controller.name,
                            hintText: AppConst.name,
                            icon: const Icon(Icons.email),
                            invisible: false,
                            validator: (name) => controller.validateFiled(name),
                            type: TextInputType.emailAddress,
                            onChange: null,
                            inputFormat: null,
                            onTap: () {},
                          ),
                          color: ColorConstants.mainScaffoldBackgroundColor,
                        ),
                        const SizedBox(height: 15),
                        textFieldLabel(AppConst.title),
                        FormWidget(
                          formmodel: FormModel(
                            enableText: false,
                            controller: controller.title,
                            hintText: AppConst.title,
                            icon: const Icon(Icons.abc),
                            invisible: false,
                            validator: (title) =>
                                controller.validateFiled(title),
                            type: TextInputType.name,
                            onChange: null,
                            inputFormat: null,
                            onTap: () {},
                          ),
                          color: ColorConstants.mainScaffoldBackgroundColor,
                        ),
                        const SizedBox(height: 15),
                        textFieldLabel(AppConst.genre),
                        FormWidget(
                          formmodel: FormModel(
                            enableText: false,
                            controller: controller.genre,
                            hintText: AppConst.genre,
                            icon: const Icon(Icons.edit),
                            invisible: false,
                            validator: (genre) =>
                                controller.validateFiled(genre),
                            type: TextInputType.visiblePassword,
                            onChange: null,
                            inputFormat: null,
                            onTap: () {},
                          ),
                          color: ColorConstants.mainScaffoldBackgroundColor,
                        ),
                        const SizedBox(height: 15),
                        const SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(0, 2)),
                            ],
                          ),
                          child: ProductButton(
                              onTap: () => {
                                    controller.movieAdded(
                                        controller.name.text,
                                        controller.title.text,
                                        controller.genre.text),
                                  },
                              title: "Next"),
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

textFieldLabel(String title) {
  return Text(title.tr,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: ColorConstants.mainTextColor)));
}
