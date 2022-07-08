import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/webview_screen/webview_screen.dart';

Widget buildArticleItem(Map article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebviewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          children: [
            Container(
              width: 105.0,
              height: 105.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(
                      '${article['urlToImage'] ?? "https://via.placeholder.com/150?text=image+not+found"}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 15.0),
            Expanded(
              child: Container(
                height: 105.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );

Widget buildListItems(List<dynamic> list, {bool isSearch = false}) =>
    ConditionalBuilder(
      condition: list.length > 0,
      fallback: (context) => isSearch
          ? Container()
          : const Center(child: CircularProgressIndicator()),
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: list.length,
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

defaultTextField({
  required String label,
  IconData? prefixIcon,
  Function()? onTap,
  Function(String value)? onChange,
  IconData? suffixIcon,
  TextInputType? keyboard,
  bool obscurePassword = false,
  bool isClickable = true,
  Function()? onPressedSuffix,
  TextEditingController? controller,
  FormFieldValidator? validate,
}) =>
    TextFormField(
      // style: TextStyle(color: Colors.white),
      style: TextStyle(color: Colors.grey),
      controller: controller,
      keyboardType: keyboard,
      validator: validate,
      onTap: onTap,
      onChanged: onChange,
      enabled: isClickable,
      obscureText: obscurePassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Colors.grey,
              )
            : null,
        suffixIcon: suffixIcon != null
            ? IconButton(onPressed: onPressedSuffix, icon: Icon(suffixIcon))
            : null,
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),
    );
