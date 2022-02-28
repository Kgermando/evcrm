import 'package:auto_size_text/auto_size_text.dart';
import 'package:crm_spx/src/global/repository/campaigns/campaign_repository.dart';
import 'package:crm_spx/src/models/campaign_model.dart';
import 'package:crm_spx/src/models/user_model.dart';
import 'package:crm_spx/src/provider/theme_provider.dart';
import 'package:crm_spx/src/services/user_preferences.dart';
import 'package:flutter/material.dart';

class TitleItemWidget extends StatefulWidget {
  const TitleItemWidget({Key? key, required this.campaignModel})
      : super(key: key);
  final CampaignModel campaignModel;

  @override
  _TitleItemWidgetState createState() => _TitleItemWidgetState();
}

class _TitleItemWidgetState extends State<TitleItemWidget> {
  String? title;
  String? subTitle;

  @override
  void initState() {
    userPrefs();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String? userName;
  String? role;
  String? superviseur;

  void userPrefs() async {
    User user = await UserPreferences.read();
    setState(() {
      userName = user.userName;
      role = user.role;
      superviseur = user.superviseur;
    });
  }

  @override
  Widget build(BuildContext context) {
    final headline5 = Theme.of(context).textTheme.headline5;
    final headline6 = Theme.of(context).textTheme.headline6;
    return Column(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: AutoSizeText(
                (widget.campaignModel.title == '')
                    ? title.toString()
                    : widget.campaignModel.title,
                maxLines: 3,
                style: headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ThemeProvider().isDarkMode
                        ? Colors.white
                        : Colors.black),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: AutoSizeText(
                (widget.campaignModel.subTitle == '')
                    ? subTitle.toString()
                    : widget.campaignModel.subTitle,
                textAlign: TextAlign.center,
                maxLines: 5,
                style: headline6!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ),
          ],
        ),
        TextFormField(
          maxLength: 50,
          decoration: InputDecoration(
            labelText: 'Titre du scripting',
            labelStyle: const TextStyle(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onChanged: (value) {
            setState(() {
              title = value;
              updateCampaign();
            });
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextFormField(
          maxLength: 150,
          decoration: InputDecoration(
            labelText: 'Description',
            labelStyle: const TextStyle(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onChanged: (value) {
            setState(() {
              subTitle = value;
              updateCampaign();
            });
          },
        ),
      ],
    );
  }

  Future<void> updateCampaign() async {
    final campaignModel = CampaignModel(
        id: widget.campaignModel.id,
        campaignName: widget.campaignModel.campaignName,
        scripting: [],
        title: title.toString(),
        subTitle: subTitle.toString(),
        date: widget.campaignModel.date,
        userName: userName!,
        superviseur: superviseur!);

    await CampaignRepository().updateData(campaignModel);
    // Navigator.of(context).pop();
    // if (!mounted) return;
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text("${campaignModel.campaignName} ajouté!"),
    //   backgroundColor: Colors.green[700],
    // ));
  }
}
