import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

import '../activity_indicator/activity_indicator.dart';
import '../colors.dart';
import '../constants/styles.dart';
import '../utils/custom_textfield.dart';
import '../utils/elevated_btn.dart';

class LanguageTranslatorView extends StatefulWidget {
  @override
  State<LanguageTranslatorView> createState() => _LanguageTranslatorViewState();
}

class _LanguageTranslatorViewState extends State<LanguageTranslatorView> {
  String? _translatedText;
  final _controller = TextEditingController();
  final _modelManager = OnDeviceTranslatorModelManager();
  final _sourceLanguage = TranslateLanguage.english;
  final _targetLanguage = TranslateLanguage.spanish;
  late final _onDeviceTranslator = OnDeviceTranslator(
      sourceLanguage: _sourceLanguage, targetLanguage: _targetLanguage);

  @override
  void dispose() {
    _onDeviceTranslator.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('On-device Translation'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                SizedBox(height: 30),
                Text('Enter text (source: ${_sourceLanguage.name})'),
                SizedBox(height: 8),
                // Container(
                //   height: 40,
                //  // padding: EdgeInsets.symmetric(horizontal: 20),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //       border: Border.all(
                //     width: 1,
                //   )),
                //   child: TextField(
                //     controller: _controller,
                //     decoration: InputDecoration(border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 8.0),),
                //     maxLines: null,
                //   ),
                // ),
                Container(
                  height: 40,
                  child: TextFormFieldCustom(
                    controller: _controller,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                    'Translated Text (target: ${_targetLanguage.name})'),
                SizedBox(height: 8),
                Container(
                   // height: 45,
                    width: MediaQuery.of(context).size.width / 1.3,
                    padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                      width: 1,
                    )),
                    child: SelectableText(_translatedText ?? '')),
                SizedBox(height: 20),
                ElevatedBtn(
                    onPressed: _translateText,
                  text: 'Translate',color: readColor,),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: _downloadSourceModel,
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(clearColor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ))),
                        child: Text(
                          'Download Source Model',
                          style: TextStyle(fontSize: 12),
                        )),
                    ElevatedButton(
                        onPressed: _downloadTargetModel,
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(deleteColor!),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ))),
                        child: Text(
                          'Download Target Model',
                          style: TextStyle(fontSize: 12),
                        )),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: _deleteSourceModel,
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(deleteColor!),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ))),
                        child: Text('Delete Source Model')),
                    ElevatedButton(
                        onPressed: _deleteTargetModel,
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(deleteColor!),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ))),
                        child: Text('Delete Target Model')),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: _isSourceModelDownloaded,
                        style: ButtonStyle(
                         //   backgroundColor: MaterialStateProperty.all<Color>(deleteColor!),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ))),
                        child: Text('Source Downloaded?')),
                    ElevatedButton(
                        onPressed: _isTargetModelDownloaded,
                        style: ButtonStyle(
                           // backgroundColor: MaterialStateProperty.all<Color>(deleteColor!),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ))),
                        child: Text('Target Downloaded?')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _downloadSourceModel() async {
    Toast().show(
        'Downloading model (${_sourceLanguage.name})...',
        _modelManager
            .downloadModel(_sourceLanguage.bcpCode)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _downloadTargetModel() async {
    Toast().show(
        'Downloading model (${_targetLanguage.name})...',
        _modelManager
            .downloadModel(_targetLanguage.bcpCode)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _deleteSourceModel() async {
    Toast().show(
        'Deleting model (${_sourceLanguage.name})...',
        _modelManager
            .deleteModel(_sourceLanguage.bcpCode)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _deleteTargetModel() async {
    Toast().show(
        'Deleting model (${_targetLanguage.name})...',
        _modelManager
            .deleteModel(_targetLanguage.bcpCode)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _isSourceModelDownloaded() async {
    Toast().show(
        'Checking if model (${_sourceLanguage.name}) is downloaded...',
        _modelManager
            .isModelDownloaded(_sourceLanguage.bcpCode)
            .then((value) => value ? 'downloaded' : 'not downloaded'),
        context,
        this);
  }

  Future<void> _isTargetModelDownloaded() async {
    Toast().show(
        'Checking if model (${_targetLanguage.name}) is downloaded...',
        _modelManager
            .isModelDownloaded(_targetLanguage.bcpCode)
            .then((value) => value ? 'downloaded' : 'not downloaded'),
        context,
        this);
  }

  Future<void> _translateText() async {
    FocusScope.of(context).unfocus();
    final result = await _onDeviceTranslator.translateText(_controller.text);
    setState(() {
      _translatedText = result;
    });
  }
}
