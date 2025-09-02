import 'package:avk/router/path_exporter.dart';

/// A customizable base button widget that wraps its [child] inside an [InkWell].
///
/// This widget removes default splash, highlight, and hover colors to give a clean
/// interaction effect, making it ideal for building custom-styled buttons.
///
/// Example usage:
/// ```dart
/// BaseButton(
///   onTap: () => print("Button pressed"),
///   child: Container(
///     padding: EdgeInsets.all(12),
///     color: Colors.blue,
///     child: Text("Click Me", style: TextStyle(color: Colors.white)),
///   ),
/// )
/// ```
class BaseButton extends StatelessWidget {
  /// Creates a [BaseButton] with the given [child] widget.
  ///
  /// The [onTap] callback is triggered when the button is tapped.
  const BaseButton({required this.child, super.key, this.onTap});

  /// Callback function triggered when the button is tapped.
  final Function()? onTap;

  /// The widget to be displayed inside the button.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: (){
        bool isNoInternet = BlocProvider.of<NoInternetBloc>(context).internetStateIsDisconnect;
        if(!isNoInternet){
          onTap?.call();
        }
      },
      child: child,
    );
  }
}
