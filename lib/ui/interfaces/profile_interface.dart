import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ktr_msc_ls1/core/constants/app_contstants.dart';
import 'package:ktr_msc_ls1/core/viewmodels/views/profile_view_model.dart';
import 'package:ktr_msc_ls1/ui/interfaces/base_interface.dart';
import 'package:ktr_msc_ls1/ui/shared/app_colors.dart';
import 'package:ktr_msc_ls1/ui/shared/ui_helper.dart';
import 'package:ktr_msc_ls1/ui/shared/validators.dart';
import 'package:ktr_msc_ls1/ui/widgets/input_field.dart';
import 'package:ktr_msc_ls1/ui/widgets/rounded_btn.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProfileInterface extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileInterfaceState();
}

class ProfileInterfaceState extends State<ProfileInterface> {
  TapGestureRecognizer _tapLogin;
  final _formKey = GlobalKey<FormState>();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _companyFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  TextEditingController _nameController;
  TextEditingController _companyController;
  TextEditingController _emailController;
  TextEditingController _phoneController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _tapLogin = TapGestureRecognizer()..onTap = _handlePress;
    _nameController = TextEditingController();
    _companyController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void _handlePress() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _tapLogin?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseInterface<ProfileViewModel>(
      model: ProfileViewModel(
        authenticationService: Provider.of(context),
        localStorageService: Provider.of(context),
      ),
      builder: (context, model, child) => Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            color: backgroundColor,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            UIHelper.verticalSpaceMedium,
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Create Profile',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            UIHelper.verticalSpaceMedium,
                            InputField(
                              controller: _nameController,
                              labelText: "Your name",
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              currentFocusNode: _nameFocus,
                              nextFocusNode: _companyFocus,
                              validator: (value) => Validators.required(value),
                              suffixIcon: Icon(
                                Icons.account_circle,
                                color: Colors.white,
                              ),
                            ),
                            InputField(
                              controller: _companyController,
                              labelText: "Company Name",
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              currentFocusNode: _companyFocus,
                              nextFocusNode: _emailFocus,
                              suffixIcon: Icon(
                                Icons.home,
                                color: Colors.white,
                              ),
                            ),
                            InputField(
                              controller: _emailController,
                              labelText: "Email",
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              currentFocusNode: _emailFocus,
                              nextFocusNode: _phoneFocus,
                              validator: (value) =>
                                  Validators.validateEmail(value),
                              suffixIcon: Icon(
                                Icons.alternate_email,
                                color: Colors.white,
                              ),
                            ),
                            InputField(
                              controller: _phoneController,
                              labelText: "Phone",
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              currentFocusNode: _phoneFocus,
                              nextFocusNode: _passwordFocus,
                              validator: (value) =>
                                  Validators.validateEmail(value),
                              suffixIcon: Icon(
                                Icons.phone_android,
                                color: Colors.white,
                              ),
                            ),
                            InputField(
                                controller: _passwordController,
                                labelText: "Password",
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                currentFocusNode: _passwordFocus,
                                validator: (value) =>
                                    Validators.validatePassword(value),
                                suffixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                obscureText: true),
                            UIHelper.verticalSpaceMedium,
                            RoundedButton(
                                text: "Signup",
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    bool result = await model.signUp();
                                    if (result) {
                                      Navigator.pushNamed(
                                        context,
                                        RoutePaths.Library,
                                      );
                                    }
                                  }
                                }),
                            UIHelper.verticalSpaceMedium,
                            Align(
                              alignment: Alignment.center,
                              child: RichText(
                                text: TextSpan(
                                    text: "Already have an account? ",
                                    children: [
                                      TextSpan(
                                          text: "Login",
                                          style: TextStyle(color: accentColor),
                                          recognizer: _tapLogin),
                                    ]),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
