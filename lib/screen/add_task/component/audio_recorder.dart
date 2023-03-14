import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:todo/config/themes/my_drawing.dart';

class AudioRecorder extends StatefulWidget {
  final void Function(String path) onStop;

  const AudioRecorder({Key? key, required this.onStop}) : super(key: key);

  @override
  State<AudioRecorder> createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  int _recordDuration = 0;
  Timer? _timer;
  final _audioRecorder = Record();
  StreamSubscription<RecordState>? _recordSub;
  RecordState _recordState = RecordState.stop;
  StreamSubscription<Amplitude>? _amplitudeSub;
  Amplitude? _amplitude;

  @override
  void initState() {
    _recordSub = _audioRecorder.onStateChanged().listen((recordState) {
      setState(() => _recordState = recordState);
    });

    _amplitudeSub = _audioRecorder
        .onAmplitudeChanged(const Duration(milliseconds: 300))
        .listen((amp) => setState(() => _amplitude = amp));

    super.initState();
  }

  Future<void> _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final isSupported = await _audioRecorder.isEncoderSupported(
          AudioEncoder.aacLc,
        );
        if (kDebugMode) {
          print('${AudioEncoder.aacLc.name} supported: $isSupported');
        }
        await _audioRecorder.start();
        _startTimer();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _stop() async {
    _timer?.cancel();
    _recordDuration = 0;

    final path = await _audioRecorder.stop();

    if (path != null) {
      widget.onStop(path);
    }
    if (mounted) {}
    Navigator.pop(context);
  }

  Future<void> _pause() async {
    _timer?.cancel();
    await _audioRecorder.pause();
  }

  Future<void> _resume() async {
    _startTimer();
    await _audioRecorder.resume();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recordSub?.cancel();
    _amplitudeSub?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }

    return numberStr;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);
    return Text(
      '$minutes : $seconds',
      style: const TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildRecordStopControl();
  }

  Widget _buildRecordStopControl() {
    late Icon icon;
    late Color color;
    final theme = Theme.of(context);
    icon = const Icon(Icons.mic, color: MyColors.white, size: 30);
    color = theme.primaryColor.withOpacity(0.1);

    return Column(
      children: [
        Flexible(flex: 1, child: Container()),
        Flexible(
          flex: 1,
          child: Center(
            child: ClipOval(
              child: Material(
                color: color,
                child: Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 150,
                  color: (_recordState != RecordState.stop &&
                          _recordState != RecordState.pause)
                      ? MyColors.pinkLight
                      : MyColors.grey_60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: SizedBox(width: 56, height: 56, child: icon),
                        onTap: () => onButtonClick(),
                      ),
                      _buildTimer()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.clear,
                      color: MyColors.white,
                    ),
                  ),
                  ClipOval(
                    child: Material(
                      child: Container(
                        width: 50,
                        height: 50,
                        color: (_recordState != RecordState.stop &&
                                _recordState != RecordState.pause)
                            ? MyColors.pinkLight
                            : MyColors.white,
                        child: InkWell(
                          onTap: () => onButtonClick(),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => _stop(),
                    child: const Icon(
                      Icons.check,
                      color: MyColors.white,
                    ),
                  ),
                ],
              ),
            ))
      ],
    );
  }

  onButtonClick() {
    _recordState == RecordState.stop
        ? _start()
        : _recordState == RecordState.record
            ? _pause()
            : _resume();
  }
}
