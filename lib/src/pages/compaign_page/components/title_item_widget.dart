import 'package:auto_size_text/auto_size_text.dart';
import 'package:crm_spx/src/global/repository/campaigns/campaign_repository.dart';
import 'package:crm_spx/src/models/campaign_model.dart';
import 'package:crm_spx/src/provider/theme_provider.dart';
import 'package:flutter/material.dart';

class TitleItemWidget extends StatefulWidget {
  const TitleItemWidget({Key? key, required this.campaignModel})
      : super(key: key);
  final CampaignModel campaignModel;

  @override
  _TitleItemWidgetState createState() => _TitleItemWidgetState();
}

class _TitleItemWidgetState extends State<TitleItemWidget> {
  final title = TextEditingController();
  final subTitle = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    title.dispose();
    subTitle.dispose();
    super.dispose();
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
                    ? title.text
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
                    ? subTitle.text
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
          controller: title,
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
              title.text = value;
              title.selection = TextSelection.fromPosition(
                  TextPosition(offset: title.text.length));
              updateCampaign();
            });
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: subTitle,
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
              subTitle.text = value;
              subTitle.selection = TextSelection.fromPosition(
                  TextPosition(offset: subTitle.text.length));
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
      title: title.text,
      subTitle: subTitle.text,
      date: widget.campaignModel.date,
      userName: 'Admin',
      superviseur: ''
    );

    await CampaignRepository().updateData(campaignModel);
    // Navigator.of(context).pop();
    // if (!mounted) return;
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text("${campaignModel.campaignName} ajouté!"),
    //   backgroundColor: Colors.green[700],
    // ));
  }
}
