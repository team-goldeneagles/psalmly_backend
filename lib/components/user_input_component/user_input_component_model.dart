import '/flutter_flow/flutter_flow_util.dart';
import 'user_input_component_widget.dart' show UserInputComponentWidget;
import 'package:flutter/material.dart';

class UserInputComponentModel
    extends FlutterFlowModel<UserInputComponentWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
