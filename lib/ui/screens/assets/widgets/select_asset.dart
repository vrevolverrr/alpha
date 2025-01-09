import 'package:alpha/ui/common/alpha_container.dart';
import 'package:flutter/material.dart';

class SelectableAsset extends StatefulWidget {
  const SelectableAsset({super.key});

  @override
  State<SelectableAsset> createState() => _SelectableAssetState();
}

class _SelectableAssetState extends State<SelectableAsset> {
  @override
  Widget build(BuildContext context) {
    return AlphaContainer(
      width: 420.0,
      height: 560.0,
    );
  }
}
