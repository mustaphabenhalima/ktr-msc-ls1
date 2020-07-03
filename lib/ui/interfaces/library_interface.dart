import 'package:flutter/material.dart';
import 'package:ktr_msc_ls1/core/constants/app_contstants.dart';
import 'package:ktr_msc_ls1/core/viewmodels/views/library_view_model.dart';
import 'package:ktr_msc_ls1/ui/interfaces/base_interface.dart';
import 'package:ktr_msc_ls1/ui/shared/app_sizes.dart';
import 'package:ktr_msc_ls1/ui/shared/ui_helper.dart';
import 'package:ktr_msc_ls1/ui/shared/validators.dart';
import 'package:ktr_msc_ls1/ui/widgets/input_field.dart';
import 'package:ktr_msc_ls1/ui/widgets/item_business_card.dart';
import 'package:ktr_msc_ls1/ui/widgets/rounded_btn.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LibraryInterface extends StatefulWidget {
  @override
  _LibraryInterfaceState createState() => _LibraryInterfaceState();
}

class _LibraryInterfaceState extends State<LibraryInterface> {
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
    _nameController = TextEditingController();
    _companyController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
  }


  Future<void> addCard(LibraryViewModel libraryViewModel) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          UIHelper.verticalSpaceMedium,
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Add Business card',
                              style: TextStyle(
                                color: Colors.black,
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
                            textColor: Colors.black,
                            validator: (value) => Validators.required(value),
                            prefixIcon: Icon(
                              Icons.account_circle,
                              color: Colors.black,
                            ),
                          ),
                          InputField(
                            controller: _companyController,
                            labelText: "Company Name",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            currentFocusNode: _companyFocus,
                            textColor: Colors.black,
                            nextFocusNode: _emailFocus,
                            prefixIcon: Icon(
                              Icons.home,
                              color: Colors.black,
                            ),
                          ),
                          InputField(
                            controller: _emailController,
                            labelText: "Email",
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            textColor: Colors.black,
                            currentFocusNode: _emailFocus,
                            nextFocusNode: _phoneFocus,
                            validator: (value) =>
                                Validators.validateEmail(value),
                            prefixIcon: Icon(
                              Icons.alternate_email,
                              color: Colors.black,
                            ),
                          ),
                          InputField(
                            controller: _phoneController,
                            labelText: "Phone",
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            currentFocusNode: _phoneFocus,
                            textColor: Colors.black,
                            prefixIcon: Icon(
                              Icons.phone_android,
                              color: Colors.black,
                            ),
                          ),
                          UIHelper.verticalSpaceMedium,
                          RoundedButton(
                              text: "Add",
                              color: Colors.blue,
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  await libraryViewModel.addCard(
                                    _nameController.text,
                                    _companyController.text,
                                    _emailController.text,
                                    _phoneController.text,
                                  );
                                  Navigator.pop(
                                    context,
                                  );
                                }
                              }),
                        ],
                      ),
                      Positioned(
                          top: -5,
                          right: -5,
                          child: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print("HomeView build");
    return BaseInterface<LibraryViewModel>(
      model: LibraryViewModel(
        dataService: Provider.of(context),
        localStorageService: Provider.of(context),
      ),
      onModelReady: (model) => model.init(),
      builder: (BuildContext context, LibraryViewModel libraryViewModel,
              Widget child) =>
          libraryViewModel.isLoading
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                )
              : Scaffold(
                  appBar: AppBar(
                    title: Text(
                      "Library",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    actions: <Widget>[
                      IconButton(icon: Icon(Icons.exit_to_app), onPressed: ()async{
                        await libraryViewModel.logout();
                        Navigator.pushNamedAndRemoveUntil(context, RoutePaths.Login, (route) => false);
                      })
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      addCard(libraryViewModel);
                    },
                    child: Icon(Icons.add),
                  ),
                  body: Column(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          child: Container(
                              color: Colors.grey.withOpacity(0.5),
                              child: libraryViewModel.cards != null &&
                                      libraryViewModel.cards.length > 0
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: kViewBottomPadding),
                                      child: RefreshIndicator(
                                        onRefresh: () async {
                                          await libraryViewModel.init();
                                        },
                                        child: ListView.builder(
                                          itemCount:
                                              libraryViewModel.cards.length,
                                          itemBuilder: (context, index) =>
                                              ItemBusinessCard(libraryViewModel
                                                  .cards[index]),
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "You don't have any Business card",
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )),
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}
