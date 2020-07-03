import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseInterface<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget child) builder;
  final Function(T) onModelReady;
  final T model;
  final Widget child;

  BaseInterface({Key key, this.model, this.onModelReady, this.builder, this.child})
      : super(key: key);

  @override
  _BaseInterfaceState<T> createState() => _BaseInterfaceState<T>();
}

class _BaseInterfaceState<T extends ChangeNotifier> extends State<BaseInterface<T>> {
  T model;

  @override
  void initState() {
    // assign the model once when state is initialised
    model = widget.model;
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
