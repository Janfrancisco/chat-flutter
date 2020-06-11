import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';

class TextCompose extends StatefulWidget {
  TextCompose(this.sendMessage);
  final Function({String text, File imgFile}) sendMessage;
  @override
  _TextComposeState createState() => _TextComposeState();
}

class _TextComposeState extends State<TextCompose> {
  final TextEditingController _controller = TextEditingController();
  void _reset() {
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }

  bool _isComposing = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 8),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () async {
              PickedFile pck =
                  await ImagePicker().getImage(source: ImageSource.gallery);
              final File imgFile = File(pck.path);
              if (imgFile == null) return;

              int sizeFile = await imgFile.length();
              print('size: ' + sizeFile.toString());
              if (sizeFile > 500000) {
                File compressedFile = await FlutterNativeImage.compressImage(
                  imgFile.path,
                  quality: 80,
                );
                widget.sendMessage(imgFile: compressedFile);
                int sizedFile = await compressedFile.length();
                print('sized: ' + sizedFile.toString());
              } else {
                widget.sendMessage(imgFile: imgFile);
              }
            },
          ),
          Expanded(
            child: TextField(
              maxLines: null,
              decoration: InputDecoration.collapsed(
                hintText: 'Enviar uma mensagem',
              ),
              onChanged: (text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                widget.sendMessage(text: text);
                _reset();
              },
              controller: _controller,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _isComposing
                ? () {
                    widget.sendMessage(text: _controller.text);
                    _reset();
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
