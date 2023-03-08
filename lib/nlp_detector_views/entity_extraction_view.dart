import 'package:flutter/material.dart';
import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';

import '../activity_indicator/activity_indicator.dart';
import '../colors.dart';
import '../utils/custom_textfield.dart';
import '../utils/elevated_btn.dart';

class EntityExtractionView extends StatefulWidget {
  @override
  State<EntityExtractionView> createState() => _EntityExtractionViewState();
}

class _EntityExtractionViewState extends State<EntityExtractionView> {
  final _controller = TextEditingController();
  final _modelManager = EntityExtractorModelManager();
  final _entityExtractor =
      EntityExtractor(language: EntityExtractorLanguage.english);
  var _entities = <EntityAnnotation>[];
  final _language = EntityExtractorLanguage.english;

  @override
  void dispose() {
    _entityExtractor.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Entity Extractor'),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text('Enter text (English)')),
                  SizedBox(height: 10),
                  Container(
                    height: 45,
                    child: TextFormFieldCustom(
                      controller: _controller,
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    Expanded(
                      child: ElevatedBtn(
                          onPressed: _extractEntities,
                          text: 'Extract Entities',color: readColor,),
                    ),
                    SizedBox(width: 8,),
                    Expanded(
                        child:  ElevatedBtn(
                        onPressed: _isModelDownloaded,
                        text: 'Check download',color: clearColor,)),
                  ]),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: ElevatedBtn(
                            onPressed: _downloadModel,
                            text: 'Download Model',color: downloadColor),
                      ),
                      SizedBox(width: 8.0,),
                      Expanded(
                        child: ElevatedBtn(
                            onPressed: _deleteModel, text: 'Delete Model',color: deleteColor),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  // Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: [
                  //       ElevatedButton(
                  //           onPressed: _isModelDownloaded,
                  //           child: Text('Check download'))
                  //     ]),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text('Result:', style: TextStyle(fontSize: 20))),
                  _entities.isNotEmpty ?
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _entities.length,
                    itemBuilder: (context, index) => ExpansionTile(
                        title: Text(_entities[index].text),
                        children: _entities[index]
                            .entities
                            .map((e) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text('${e.type.name}: $e'),
                            ))
                            .toList()),
                  ): _entities.isEmpty && _controller.text != ''? Text('Unknown'):Text(''),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _downloadModel() async {
    Toast().show(
        'Downloading model...',
        _modelManager
            .downloadModel(_language.name)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _deleteModel() async {
    Toast().show(
        'Deleting model...',
        _modelManager
            .deleteModel(_language.name)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _isModelDownloaded() async {
    Toast().show(
        'Checking if model is downloaded...',
        _modelManager
            .isModelDownloaded(_language.name)
            .then((value) => value ? 'downloaded' : 'not downloaded'),
        context,
        this);
  }

  Future<void> _extractEntities() async {
    FocusScope.of(context).unfocus();
    final result = await _entityExtractor.annotateText(_controller.text);
    setState(() {
      _entities = result;
    });
  }
}
