import 'package:flutter/material.dart';

class TermsWidget extends StatefulWidget {
  const TermsWidget({super.key});

  @override
  State<TermsWidget> createState() => _TermsWidgetState();
}

class _TermsWidgetState extends State<TermsWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            _showTermsDialog(context);
          },
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
              children: [
                TextSpan(text: "قوانین برنامه"),
                TextSpan(
                  text: "هتلینو",
                  style: TextStyle(
                    fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.primary
                  ),
                  
                ),
                TextSpan(text: "را خوانده و آنها را میپذیرم.")
              ]
            ),
            textDirection: TextDirection.rtl,
          ),
        ),
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2)
          ),
          activeColor: Theme.of(context).colorScheme.primary,
        )
      ],
    );
  }

  void _showTermsDialog(BuildContext context) {
    showModalBottomSheet(context: context, 
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "قوانین برنامه هتلینو",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            SizedBox(height: 16,),
            Text(
              "این برنامه به منظور ارائه‌ی خدمات رزرو هتل طراحی و توسعه یافته است. هدف ما این است که کاربران بتوانند به راحتی هتل‌های مختلف را جستجو کرده و با توجه به نیازهای خود اقدام به رزرو نمایند.\n\n"
              "کاربران می‌توانند پروفایل شخصی خود را ایجاد کرده و تجربه‌ای بهتر از جستجو و انتخاب هتل داشته باشند. توجه داشته باشید که رزروهای انجام‌شده نهایی بوده و امکان لغو یا تغییر آن‌ها وجود ندارد.\n\n"
              "قیمت‌های اعلام‌شده برای هر هتل ثابت بوده و پس از رزرو، هیچ‌گونه تغییری در آن‌ها اعمال نخواهد شد. همچنین، اطلاعات هتل‌ها به طور منظم بررسی و به‌روزرسانی می‌شوند تا تجربه‌ای مطمئن و رضایت‌بخش برای شما فراهم شود.",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    },);
  }
}