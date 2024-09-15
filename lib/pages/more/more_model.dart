import '/components/nav_bar_component/nav_bar_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'more_widget.dart' show MoreWidget;
import 'package:flutter/material.dart';

class MoreModel extends FlutterFlowModel<MoreWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for NavBarComponent component.
  late NavBarComponentModel navBarComponentModel;

  @override
  void initState(BuildContext context) {
    navBarComponentModel = createModel(context, () => NavBarComponentModel());
  }

  @override
  void dispose() {
    navBarComponentModel.dispose();
  }
}
