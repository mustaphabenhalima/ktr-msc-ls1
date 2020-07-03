import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ktr_msc_ls1/core/constants/app_contstants.dart';
import 'package:ktr_msc_ls1/core/viewmodels/views/login_view_model.dart';
import 'package:ktr_msc_ls1/ui/interfaces/base_interface.dart';
import 'package:ktr_msc_ls1/ui/shared/app_colors.dart';
import 'package:ktr_msc_ls1/ui/shared/ui_helper.dart';
import 'package:ktr_msc_ls1/ui/shared/validators.dart';
import 'package:ktr_msc_ls1/ui/widgets/input_field.dart';
import 'package:ktr_msc_ls1/ui/widgets/rounded_btn.dart';
import 'package:provider/provider.dart';

class LoginInterface extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginInterfaceState();
}

class LoginInterfaceState extends State<LoginInterface> {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseInterface<LoginViewModel>(
      model: LoginViewModel(
          authenticationService: Provider.of(context),
          localStorageService: Provider.of(context)),
      builder: (context, model, child) => Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/login_bg.jpg'),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.darken),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 12.0, bottom: 12.0, left: 12.0),
                child: LayoutBuilder(
                  builder: (BuildContext context,
                          BoxConstraints viewportConstraints) =>
                      SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: viewportConstraints.maxHeight),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'EPITECH',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            UIHelper.verticalSpaceMedium,
                            InputField(
                              controller: _emailController,
                              labelText: "Email",
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              currentFocusNode: _emailFocus,
                              nextFocusNode: _passwordFocus,
                              validator: (value) =>
                                  Validators.validateEmail(value),
                              suffixIcon: Icon(
                                Icons.alternate_email,
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
                              text: "Login",
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  bool result = await model.login(
                                      _emailController.text,
                                      _passwordController.text);
                                  if (result != null) {
                                    Navigator.pushReplacementNamed(
                                        context, RoutePaths.Library);
                                  }
                                }
                              },
                            ),
                            UIHelper.verticalSpaceMedium,
                            Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RoutePaths.Profile);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: RichText(
                                    text: TextSpan(
                                        text: "You don't have an account? ",
                                        children: [
                                          TextSpan(
                                            text: "Signup",
                                            style:
                                                TextStyle(color: accentColor),
                                          ),
                                        ]),
                                  ),
                                ),
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
