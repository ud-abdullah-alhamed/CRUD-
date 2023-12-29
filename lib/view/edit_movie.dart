import 'package:desktopapp/constant/app_const.dart';
import 'package:desktopapp/constant/color.dart';
import 'package:desktopapp/controller/edit_movie_controller.dart';
import 'package:desktopapp/model/form_model.dart';
import 'package:desktopapp/view/add_movie.dart';
import 'package:desktopapp/widget/button.dart';
import 'package:desktopapp/widget/text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditMoviePage extends StatefulWidget {
  const EditMoviePage(
      {required this.name,
      required this.title,
      required this.releaseDate,
      required this.genre,
      required this.id,
      super.key});

  final String name;
  final String title;
  final String genre;
  final String releaseDate;
  final int id;

  @override
  State<EditMoviePage> createState() => _EditMoviePageState();
}

class _EditMoviePageState extends State<EditMoviePage> {
  final controller = Get.put(EditMovie());

  @override
  Widget build(BuildContext context) {
    final TextEditingController id =
        TextEditingController(text: widget.id.toString());

    final TextEditingController name = TextEditingController(text: widget.name);
    final TextEditingController title =
        TextEditingController(text: widget.title);
    final TextEditingController genre =
        TextEditingController(text: widget.genre);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
        scrolledUnderElevation: 0,
        title: const Text('Movies Edit'),
      ),
      body: Column(
        children: [
          Center(
            child: Form(
                key: controller.firstFormkey,
                child: SizedBox(
                  height: 520,
                  width: 320,
                  child: ListView(
                    children: [
                      textFieldLabel(AppConst.id),
                      FormWidget(
                        formmodel: FormModel(
                          enableText: true,
                          controller: id,
                          hintText: AppConst.name,
                          icon: const Icon(Icons.email),
                          invisible: false,
                          validator: null,
                          type: TextInputType.emailAddress,
                          onChange: null,
                          inputFormat: null,
                          onTap: () {},
                        ),
                        color: ColorConstants.mainScaffoldBackgroundColor,
                      ),
                      const SizedBox(height: 15),
                      textFieldLabel(AppConst.name),
                      FormWidget(
                        formmodel: FormModel(
                          enableText: false,
                          controller: name,
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
                          controller: title,
                          hintText: AppConst.title,
                          icon: const Icon(Icons.abc),
                          invisible: false,
                          validator: (title) => controller.validateFiled(title),
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
                          controller: genre,
                          hintText: AppConst.genre,
                          icon: const Icon(Icons.edit),
                          invisible: false,
                          validator: (genre) => controller.validateFiled(genre),
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
                                  if (controller.firstFormkey.currentState!
                                      .validate())
                                    {
                                      controller.updateData(id.text.trim(),
                                          name.text, title.text, genre.text),
                                      Get.snackbar("Edited sucessful",
                                          "your data has been edit",
                                          snackPosition: SnackPosition.BOTTOM,
                                          colorText: ColorConstants
                                              .mainScaffoldBackgroundColor,
                                          backgroundColor: ColorConstants
                                              .snakbarColorsuccessful),
                                      Get.back()
                                    }
                                  else
                                    {
                                      Get.snackbar("ERROR", "Invalid Data",
                                          snackPosition: SnackPosition.BOTTOM,
                                          colorText: ColorConstants
                                              .mainScaffoldBackgroundColor,
                                          backgroundColor:
                                              ColorConstants.snakbarColorError)
                                    }
                                },
                            title: "edit"),
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
