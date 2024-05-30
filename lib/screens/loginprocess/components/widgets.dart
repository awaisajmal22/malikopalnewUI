import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          Container(
            height: 65,
            width: size.width * 0.83.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                    colors: [Color(0xff1F5FA2), Color(0xff272E6D)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            // child:
            // Neumorphic(
            child: Center(
                child: Text(
              widget.title,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w700,
                  ),
              // style: TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.black54),
            )),
            // style: NeumorphicStyle(
            //   border: NeumorphicBorder(
            //     color: Theme.of(context).cardColor,
            //   ),
            //   shape: NeumorphicShape.flat,
            //   boxShape:
            //       NeumorphicBoxShape.roundRect(BorderRadius.circular(16)),
            //   lightSource: LightSource.topLeft,
            //   intensity: 0.7,
            //   // color: Color(0xff1F5FA2),
            // ),
          ),
          // ),
        ],
      ),
    );
  }
}

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;
  CustomPageRoute({required this.child, this.direction = AxisDirection.right})
      : super(
            transitionDuration: Duration(milliseconds: 300),
            reverseTransitionDuration: Duration(milliseconds: 300),
            pageBuilder: (context, animation, secondaryAnimation) => child);
  @override
  Widget buildTransitions(BuildContext Context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(begin: getBeginOffset(), end: Offset.zero)
            .animate(animation),
        child: child,
      );
  Offset getBeginOffset() {
    switch (direction) {
      case AxisDirection.up:
        return Offset(0, 1);
      case AxisDirection.down:
        return Offset(0, -1);
      case AxisDirection.left:
        return Offset(-1, 0);
      case AxisDirection.right:
        return Offset(1, 0);
    }
  }
}
