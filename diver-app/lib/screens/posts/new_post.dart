import 'package:diver/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reactive_forms/reactive_forms.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final _form = fb.group({
    'postText': ['', Validators.required]
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "New",
          style: GoogleFonts.yesevaOne(fontSize: 32.0),
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).pop(context),
              icon: const Icon(Icons.close))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ReactiveForm(
            formGroup: _form,
            child: Column(
              children: [
                ReactiveTextField(
                  validationMessages: {
                    'required': (error) => 'Enter something to be able to post.'
                  },
                  formControlName: 'postText',
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: themeBasedBorderSide(context)),
                    hintText: "Write something...",
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt_rounded, size: 20.0),
                    ),
                    const SizedBox(width: 8),
                    ReactiveFormConsumer(
                        builder: (context, form, child) {
                          return FilledButton.icon(
                            onPressed: form.invalid ? null : () {},
                            icon: const Icon(
                              Icons.send_rounded,
                              size: 20.0,
                            ),
                            label: const Text("Posten"),
                          );
                        }
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
