import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EmailSender extends StatefulWidget {
  const EmailSender({Key? key}) : super(key: key);

  @override
  State<EmailSender> createState() => _EmailSenderState();
}

class _EmailSenderState extends State<EmailSender> {
  List<String> attachments = [];
  bool isHTML = false;

  final _recipientController = TextEditingController(
    text: 'example@example.com',
  );

  final _subjectController = TextEditingController(text: 'The subject');

  final _bodyController = TextEditingController(
    text: 'Request of collaboration',
  );

  void notifierAttachmentSuccess(bool success) {
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('File attached'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('File not attached'),
        ),
      );
    }
  }

  Future<void> send() async {
    //add validation
    if (_recipientController.text.isEmpty ||
        _subjectController.text.isEmpty ||
        _bodyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all the fields'),
        ),
      );
      return;
    }

    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: [_recipientController.text],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
      _closeModal();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send a message'),
        actions: <Widget>[
          IconButton(
            onPressed: send,
            icon: const Icon(Icons.send),
          )
        ],
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          // minHeight: MediaQuery.of(context).size.height,
        ),
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _recipientController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Recipient',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _subjectController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Subject',
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _bodyController,
                    keyboardType: TextInputType.multiline,
                    expands: false,
                    maxLines: 10,
                    minLines: 5,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: const InputDecoration(
                      labelText: 'Body',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    for (var i = 0; i < attachments.length; i++)
                      Row(
                        children: <Widget>[
                          Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    value: 1,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.grey),
                                  ),
                                ),
                              ),
                              Image(
                                image: FileImage(File(attachments[i])),
                                height: 50,
                              ),
                              Text(
                                '${i + 1}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: Text(
                              attachments[i].split('/').last,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove_circle),
                            onPressed: () => {_removeAttachment(i)},
                          )
                        ],
                      ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 30.0), // Add bottom padding here
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton.icon(
                                  onPressed: _openImagePicker,
                                  icon: const Icon(Icons.attach_file),
                                  label: const Text('File From Documents'),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openImagePicker() async {
    final picker = ImagePicker();
    final pick = await picker.pickImage(source: ImageSource.gallery);

    if (pick != null) {
      notifierAttachmentSuccess(true);
      setState(() {
        attachments.add(pick.path);
      });
    } else {
      notifierAttachmentSuccess(false);
    }
  }

  void _removeAttachment(int index) {
    setState(() {
      attachments.removeAt(index);
    });
  }

  void _closeModal() {
    Navigator.of(context).pop();
  }

  Future<void> _attachFileFromAppDocumentsDirectory() async {
    try {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      final filePath = '${appDocumentDir.path}/file.txt';
      final file = File(filePath);
      await file.writeAsString('Text file in app directory');

      setState(() {
        attachments.add(filePath);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to create file in application directory'),
        ),
      );
    }
  }
}
