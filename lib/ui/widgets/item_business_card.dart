import 'package:flutter/material.dart';
import 'package:ktr_msc_ls1/core/models/business_card.dart';

class ItemBusinessCard extends StatelessWidget {
  final BusinessCard businessCard;

  ItemBusinessCard(this.businessCard);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text("${businessCard.name}",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                leading: Icon(Icons.account_circle),
                trailing: Text("${businessCard.companyName??""}",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              ListTile(
                title: Text("${businessCard.phone??""}"),
                leading: Icon(Icons.phone_android),
              ),
              ListTile(
                title: Text("${businessCard.email}"),
                leading: Icon(Icons.email),
              )
            ],
          ),
        ),
      ),
    );
  }
}
