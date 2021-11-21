import 'package:flutter/widgets.dart';

typedef AsyncStreamsWidgetBuilder<T> = Widget Function(BuildContext context, List<AsyncSnapshot<T>> snapshots);

class SameTypeStreamsBuilder<T> extends StatelessWidget {
  final List<Stream<T>> streams;
  final AsyncStreamsWidgetBuilder<T> builder;

  SameTypeStreamsBuilder({
    required this.streams,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return _SameTypeStreamsBuilder<T>(
      streams: streams,
      upperStreamsSnapshots: [],
      builder: builder,
    );
  }
}

class _SameTypeStreamsBuilder<T> extends StatelessWidget {
  final List<Stream<T>> streams;
  final List<AsyncSnapshot<T>> upperStreamsSnapshots;
  final AsyncStreamsWidgetBuilder<T> builder;

  _SameTypeStreamsBuilder({
    required this.streams,
    required this.upperStreamsSnapshots,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    if (streams.isEmpty) return builder(context, upperStreamsSnapshots);

    return StreamBuilder<T>(
      stream: streams[0],
      builder: _buildWithFirstSnapshot,
    );
  }

  Widget _buildWithFirstSnapshot(BuildContext context, AsyncSnapshot<T> snapshot) {
    return _SameTypeStreamsBuilder<T>(
      streams: streams.sublist(1),
      upperStreamsSnapshots: [...upperStreamsSnapshots, snapshot],
      builder: builder,
    );
  }
}
