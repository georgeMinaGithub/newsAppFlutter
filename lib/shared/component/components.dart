
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view.dart';


//......................   default Button   ....................................
Widget defaultButton(
    {
      Color color = Colors.blueAccent,
      double width = double.infinity,
      required VoidCallback onPressed,
      double radius = 10,
      required String text,
      bool isUppercase = false,

    }) =>
    Container(
      height: 40,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      child: MaterialButton(
        height: 40,
        minWidth: double.infinity,
        onPressed: onPressed,
        child:  Text(
          !isUppercase ?text : text.toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        ),
      ),
    );


// ......................  default Text Form Filed      .......................

Widget defaultTextFormField({
  FocusNode? focusNode,
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String?) validator,
  required String label,
  String? hint,
  onTap,
  onChanged,
  Function(String)? onFieldSubmitted,
  bool isPassword = false,
  bool isClickable = true,
  InputDecoration? decoration,
  IconData? suffix,
  IconData? prefix,
  Function? suffixPressed,
}) =>
    TextFormField(
      focusNode: FocusNode(),
      style: const TextStyle(),
      maxLines: 1,
      minLines: 1,
      controller: controller,
      validator: validator,
      enabled: isClickable,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      obscureText: isPassword,
      keyboardType: type,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefix,
          color: Colors.grey,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: () {
            suffixPressed!();
          },
          icon: Icon(
            suffix,
            color: Colors.grey,
          ),
        )
            : null,
        filled: true,
        isCollapsed: false,
        fillColor: Colors.deepOrange.withOpacity(0.2),
        hoverColor: Colors.red.withOpacity(0.2),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        labelText: label,
        labelStyle: const TextStyle(
          fontStyle: FontStyle.italic,
          color: Colors.deepOrangeAccent,
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white),
        focusColor: Colors.white,
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );


//  ......................   Widget Builder Article Item    ...................
Widget builderArticleItems(article, context ) =>  InkWell(
  onTap: ()
  {
    navigateTo(context, WebViewScreen(article['url']));
  },
  child: Padding(
    padding: const EdgeInsets.all(20),
    child: Row(

      children: [

        // .............................  Container to Add Image ..............
        Container(
          width: 120,
          height: 120,

          decoration: article['urlToImage'] != null ?
          BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image:  DecorationImage(
              image:  NetworkImage('${article['urlToImage']}'),
              fit: BoxFit.cover,
            ),

          )
              :
          BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image:  const DecorationImage(
              image:  AssetImage('assets/images/images.jfif'),
              fit: BoxFit.cover,
            ),

          ),
        ),
        const SizedBox(width: 20,),

        // ................... Container To Add Text (Title) ...................
        Expanded(
          child: SizedBox(
            height: 120,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
                Expanded(
                  child: Text(
                    '${article['title']}',
                   // style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                Text(
                  '${article['publishedAt']}',
                  // style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);


// .............................  Widget Divider    ............................
Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20),
  child: Container(
    width: double.infinity,
    height: 2,
    color: Colors.grey[300],
  ),
);

//......  Conditional Builder To Get Method Business Or Sports Or Science .......

Widget articleBuilder(List list,context , {isSearch = false}) => ConditionalBuilder(
  condition: list.isNotEmpty,

  builder: (context) => ListView.separated(
    physics: const BouncingScrollPhysics(),
    itemBuilder: (context, index) => builderArticleItems(list[index], context),
    separatorBuilder: (context, index) => myDivider(),
    itemCount: list.length,
  ),
  fallback: (context) => isSearch ? Container() : const Center(child: CircularProgressIndicator()),
);

// ........................    Future navigateTo     ...........................

Future navigateTo(context , widget) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>   widget ,
    )
);

// .......................   Future Navigate And Finished   ....................

Future navigateAndFinish(context , widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) =>   widget ,
  ),
      (Route<dynamic> route) => false,
);

