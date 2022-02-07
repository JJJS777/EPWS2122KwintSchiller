import 'dart:async';

import 'package:dialogflow_grpc/dialogflow_grpc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sound_stream/sound_stream.dart';

enum DialogFlowCommand {
  navigateToFavorites,
  addToFavorite,
}

class DialogFlowIntent {
  final DialogFlowCommand command;
  final String fullfilmentText;

  DialogFlowIntent(this.command, this.fullfilmentText);
}

class DialogFlowService {
  DialogFlowService._();

  static DialogFlowService? _instance;

  static DialogFlowService get instance => _instance ??= DialogFlowService._();

  final RecorderStream _recorder = RecorderStream();
  StreamSubscription? _recorderStatus;
  StreamSubscription<List<int>>? _audioStreamSubscription;
  BehaviorSubject<List<int>>? _audioStream;

  final PublishSubject<DialogFlowIntent> onCommandRecognized = PublishSubject();
//instanz erstellt
  FlutterTts flutterTts = FlutterTts();

  late DialogflowGrpcV2Beta1 dialogflow;

  bool _isRecording = false;

  bool _initialized = false;
  bool get initialized => _initialized;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlugin() async {
    if(_initialized) {
      return;
    }

    final content = await rootBundle.loadString('assets/credentials.json');
    // Get a Service account
    final serviceAccount = ServiceAccount.fromString(content);
    // Create a DialogflowGrpc Instance
    dialogflow = DialogflowGrpcV2Beta1.viaServiceAccount(
        serviceAccount); // Dialogflow-Instanz erstellt, die für Ihr Google Cloud-Projekt mit dem Dienstkonto autorisiert ist.

    _recorderStatus = _recorder.status.listen((status) {
      _isRecording = status == SoundStreamStatus.Playing;
    });

    await Future.wait([_recorder.initialize()]);

    await flutterTts.setSharedInstance(true);
    await flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.ambient,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers
        ],
        IosTextToSpeechAudioMode.voicePrompt);

    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.awaitSpeakCompletion(true);

    _initialized = true;
  }

  Future<void> speak(String text) async {
    await flutterTts.speak(text);
  }

  void stopStream() async {
    await _recorder.stop();
    await _audioStreamSubscription?.cancel();
    await _audioStream?.close();
  }

  void handleStream() {
    _recorder.start();

    _audioStream = BehaviorSubject<List<int>>();
    _audioStreamSubscription = _recorder.audioStream.listen((data) {
      _audioStream?.add(data);
    });

    // TODO Create SpeechContexts
    // Create an audio InputConfig
    var biasList = SpeechContextV2Beta1(phrases: [
      'Dialogflow CX',
      'Dialogflow Essentials',
      'Action Builder',
      'HIPAA'
    ], boost: 20.0);

    // Kodierung des Mikrofones(Hardware)
    // See: https://cloud.google.com/dialogflow/es/docs/reference/rpc/google.cloud.dialogflow.v2#google.cloud.dialogflow.v2.InputAudioConfig
    var config = InputConfigV2beta1(
        encoding: 'AUDIO_ENCODING_LINEAR_16',
        languageCode: 'de-DE',
        sampleRateHertz: 16000,
        singleUtterance: false,
        speechContexts: [biasList]);

    // TODO Make the streamingDetectIntent call, with the InputConfig and the audioStream
    final responseStream =
        dialogflow.streamingDetectIntent(config, _audioStream!);

    // TODO Get the transcript and detectedIntent and show on screen

    // Get the transcript and detectedIntent and show on screen
    responseStream.listen((data) {
      String fulfillmentText = data.queryResult.fulfillmentText;

      if (fulfillmentText.isNotEmpty) {
        if (data.queryResult.intent.name ==
            'projects/arto-agent-ktso/agent/intents/79fc4816-2dbd-4c3e-ba1c-0f71fbe36c34') {
          onCommandRecognized.add(
            DialogFlowIntent(
              DialogFlowCommand.navigateToFavorites,
              fulfillmentText,
            ),
          );
        } else if (data.queryResult.intent.name ==
            'projects/arto-agent-ktso/agent/intents/74f55e16-553b-492b-ba22-4f920681ba98') {
          onCommandRecognized.add(
            DialogFlowIntent(
              DialogFlowCommand.addToFavorite,
              fulfillmentText,
            ),
          );
        } else {
          speak(fulfillmentText);
        }
        stopStream();
      }
    }, onError: (e) {
      //print(e);
    }, onDone: () {
      //print('done');
    });
  }
}
