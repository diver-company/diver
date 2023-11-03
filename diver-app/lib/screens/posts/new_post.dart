import 'package:auto_route/auto_route.dart';
import 'package:diver/core/supabase/supabase.dart';
import 'package:diver/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:diver/generated/l10n.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  bool _submitted = false;
  final _form = fb.group({
    'postText': ['', Validators.required, Validators.maxLength(200)]
  });

  Future<void> _createPost(BuildContext context) async {
    setState(() {
      _submitted = true;
    });

    try {
      final text = _form.value['postText'];

      await supabase
          .from('posts')
          .insert({'text': text, 'creator': supabase.auth.currentUser!.id});

      if (context.mounted) {
        AutoRouter.of(context).pop();
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _submitted = false;
      });
    }
  }

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
          child: SingleChildScrollView(
            child: ReactiveForm(
              formGroup: _form,
              child: Column(
                children: [
                  ReactiveTextField(
                    validationMessages: {
                      'required': (error) => S.of(context).newPostEnterSomething
                    },
                    formControlName: 'postText',
                    maxLines: 8,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: themeBasedBorderSide(context)),
                      hintText: S.of(context).newPostHintText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ReactiveFormConsumer(
                          builder: (context, formGroup, child) {
                            final str = formGroup.value['postText'] as String;
                            return Text("${str.length}/200");
                          },
                      ),
                      Expanded(child: Container()),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.camera_alt_rounded, size: 20.0),
                      ),
                      const SizedBox(width: 8),
                      ReactiveFormConsumer(builder: (context, form, child) {
                        return FilledButton.icon(
                          onPressed: form.invalid || _submitted
                              ? null
                              : () => _createPost(context),
                          icon: _submitted
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                      color: Colors.white, strokeWidth: 3),
                                )
                              : const Icon(
                                  Icons.send_rounded,
                                  size: 20.0,
                                ),
                          label: Text(S.of(context).btn_post),
                        );
                      }),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
