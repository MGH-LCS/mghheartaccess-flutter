//  Copyright © 2020 MGH Lab of Computer Science. All rights reserved.
import 'package:flutter/material.dart';
import 'package:mghheartaccess/application/locator.dart';
import 'package:mghheartaccess/ui/viewmodel/base_model.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child)? builder;
  final Function(T)? onModelReady;
  final Function(T)? onModelClose;

  const BaseView(
      {super.key, this.builder, this.onModelReady, this.onModelClose});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.onModelClose != null) {
      widget.onModelClose!(model);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T?>(
        create: (context) => model,
        child: Consumer<T>(builder: widget.builder!));
  }
}
