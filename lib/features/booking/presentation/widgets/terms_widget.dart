import 'package:flutter/material.dart';
import 'package:hotelino/core/constants/constants.dart';
import 'package:hotelino/core/utils/kyboard.dart';

class TermsWidget extends StatefulWidget {
  static final GlobalKey<_TermsWidgetState> termsKey =
      GlobalKey<_TermsWidgetState>();
  final bool initialValue;
  final FormFieldValidator<bool>? validator;
  final FormFieldSetter<bool>? onSaved;

  TermsWidget({
    Key? key,
    required this.initialValue,
    this.validator,
    this.onSaved,
  }) : super(key: termsKey);

  @override
  State<TermsWidget> createState() => _TermsWidgetState();
}

class _TermsWidgetState extends State<TermsWidget> {
  late bool isChecked ;

  resetCheckbox() {
    setState(() {
      isChecked = false;
    });
  }

  @override
  void initState() {
    isChecked = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      initialValue: widget.initialValue,
      onSaved: widget.onSaved,
      validator: widget.validator,
      builder: (FormFieldState<bool> field) {
        //sync values
        if (field.value != isChecked) {
          field.didChange(isChecked);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      _showTermsDialog(context);
                    },
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade700,
                        ),
                        children: [
                          TextSpan(text: "قوانین برنامه"),
                          TextSpan(
                            text: "هتلینو",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          TextSpan(text: "را خوانده و آنها را میپذیرم."),
                        ],
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  Checkbox(
                    value: isChecked,
                    side: BorderSide(
                      color: field.hasError
                          ? isChecked
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(field.context).colorScheme.error
                          : isChecked
                          ? Theme.of(context).colorScheme.primary
                          : AppColors.lightBorder,
                      width: field.hasError ? 1 : 2,
                    ),
                    onChanged: (value) {
                      setState(() {
                        isChecked = value ?? false;
                        field.didChange(isChecked);
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    activeColor: Theme.of(context).colorScheme.primary,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  ),
                ],
              ),
            ),

            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 12),
                child: Text(
                  field.errorText ?? '',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void _showTermsDialog(BuildContext context) {
    unfocusEditors(context);
    showModalBottomSheet(
      context: context,
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
              SizedBox(height: 16),
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
      },
    );
  }
}
