import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
//import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit_example/test_widget.dart';
import 'nlp_detector_views/entity_extraction_view.dart';
import 'nlp_detector_views/language_identifier_view.dart';
import 'nlp_detector_views/language_translator_view.dart';
import 'nlp_detector_views/smart_reply_view.dart';
import 'vision_detector_views/barcode_scanner_view.dart';
import 'vision_detector_views/digital_ink_recognizer_view.dart';
import 'vision_detector_views/face_detector_view.dart';
import 'vision_detector_views/label_detector_view.dart';
import 'vision_detector_views/object_detector_view.dart';
import 'vision_detector_views/pose_detector_view.dart';
import 'vision_detector_views/selfie_segmenter_view.dart';
import 'vision_detector_views/text_detector_view.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(
      //DevicePreview(
    //enabled: !kReleaseMode,
   // builder: (context) =>
        MyApp(), // Wrap your app
  //)
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<int, Color> _yellow700Map = {
      50:  Color(0xff043369),
      100: Color(0xff043369),
      200: Color(0xff043369),
      300: Color(0xff043369),
      400: Color(0xff043369),
      500: Color(0xff043369),
      600: Color(0xff043369),
      700: Color(0xff043369),
      800: Color(0xff043369),
      900: Color(0xff043369),
    };

    final MaterialColor _yellow700Swatch =
    MaterialColor(Colors.blue[900]!.value, _yellow700Map);
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      useInheritedMediaQuery: true,
     // locale: DevicePreview.locale(context),
    //  builder: DevicePreview.appBuilder,
      theme:ThemeData(
      primarySwatch: _yellow700Swatch,
    ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: ExactAssetImage('assets/icons/profilegrl.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 24,width: 28,
                          decoration: BoxDecoration(
                            //shape: BoxShape.circle,
                            image: DecorationImage(
                              image: ExactAssetImage('assets/icons/notif.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                            right: 1,top: 1,
                            child: Container(height: 12,width: 12,
                              decoration: BoxDecoration(color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // SizedBox(height: 8),
                        // Align(
                        //     alignment: Alignment.topLeft,
                        //     child:  Text('Hi,\nwelcome to the Future',style: GoogleFonts.lato(
                        //       textStyle: Theme.of(context).textTheme.headline4,
                        //       fontSize: 20,
                        //       fontWeight: FontWeight.w700,
                        //       fontStyle: FontStyle.italic,
                        //     ),)),
                      //  ImageSliderDemo(),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                                child: CustomCard(
                                    'Face Detection',
                                    FaceDetectorView(),
                                    'assets/icons/facedet.png',
                                    Color(0xff3bc4c3))),
                            SizedBox(width: 8),
                            Expanded(
                                child: CustomCard('Image Labeling', ImageLabelView(),
                                    'assets/icons/il.png', Color(0xffffc844))),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: CustomCard(
                                    'Barcode Scanning',
                                    BarcodeScannerView(),
                                    'assets/icons/bc.png',
                                    Color(0xffff9066))),
                            SizedBox(width: 8),
                            Expanded(
                                child: CustomCard(
                                    'Text Recognition',
                                    TextRecognizerView(),
                                    'assets/icons/ti.png',
                                    Color(0xff58bdfd))),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: CustomCard(
                                    'Object Detection',
                                    ObjectDetectorView(),
                                    'assets/icons/od.png',
                                    Color(0xff3fd4f6))),
                            SizedBox(width: 8),
                            Expanded(
                                child: CustomCard(
                                    'Lnk Recognition',
                                    DigitalInkView(),
                                    'assets/icons/dl.png',
                                    Color(0xffb16fee))),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: CustomCard(
                                    'Pose Detection',
                                    PoseDetectorView(),
                                    'assets/icons/pd.png',
                                    Color(0xff873e23))),
                            SizedBox(width: 8),
                            Expanded(
                                child: CustomCard(
                                    'Selfie Segmentation',
                                    SelfieSegmenterView(),
                                    'assets/icons/ss.png',
                                    Color(0xff043369))),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: CustomCard(
                                    'Language ID',
                                    LanguageIdentifierView(),
                                    'assets/icons/langid.png',
                                    Color(0xfff8aa62))),
                            SizedBox(width: 8),
                            Expanded(
                                child: CustomCard(
                                    'Lang Translation',
                                    LanguageTranslatorView(),
                                    'assets/icons/lt.png',
                                    Color(0xff797dff))),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: CustomCard('Smart Reply', SmartReplyView(),
                                    'assets/icons/sr.png', Color(0xff44bcd8))),
                            SizedBox(width: 8),
                            Expanded(
                                child: CustomCard(
                                    'Entity Extraction',
                                    EntityExtractionView(),
                                    'assets/icons/ee.png',
                                    Color(0xff0a72a9))),
                          ],
                        ),
                        // ExpansionTile(
                        //   title: const Text('Vision APIs'),
                        //   children: [
                        //
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // ExpansionTile(
                        //   title: const Text('Natural Language APIs'),
                        //   children: [
                        //
                        //   ],
                        // ),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];
class ImageSliderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
            items: imgList
                .map((item) => Container(
              child: Center(
                  child:
                  Image.network(item, fit: BoxFit.cover, width: 1000)),
            ))
                .toList(),
          )
    );
  }
}

class CustomCard extends StatelessWidget {
  final String _label;
  final String _img;
  final Widget _viewPage;
  final bool featureCompleted;
  final Color color;
  final double? size;

  const CustomCard(this._label, this._viewPage, this._img, this.color,
      {this.size,this.featureCompleted = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 1.0),
      child: InkWell(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: () {
          if (!featureCompleted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    const Text('This feature has not been implemented yet')));
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => _viewPage));
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0,bottom: 16,left: 8,right: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
        //     Container(
        //       height: 60,width: 60,
        //     decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10),
        //     image: DecorationImage(
        //       image: ExactAssetImage(_img,),
        //       fit: BoxFit.fill,
        //     ),
        //   ),
        // ),
        Image.asset(
                  _img,
                  height: size?? 40,
                  width:  size?? 40,
                  color: Colors.white,fit: BoxFit.cover,
                ),
                SizedBox(height: 10),
                Text(
                  _label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    /*
      Card(
      elevation: 5,
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        tileColor: Theme.of(context).primaryColor,
        title: Text(
          _label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          if (!featureCompleted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    const Text('This feature has not been implemented yet')));
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => _viewPage));
          }
        },
      ),
    );
    */
  }
}
