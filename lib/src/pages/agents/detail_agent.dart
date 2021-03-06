import 'package:crm_spx/src/constants/responsive.dart';
import 'package:crm_spx/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DetailAgent extends StatefulWidget {
  const DetailAgent({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  _DetailAgentState createState() => _DetailAgentState();
}

class _DetailAgentState extends State<DetailAgent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text('Profil'),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  profileItem(widget.user),
                  if (Responsive.isDesktop(context))
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                  Icons.person_outline_sharp),
                              label: const Text(
                                  'Modifiez vos informations')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.password_outlined),
                              label: const Text(
                                  'Modifiez votre mot de passe')),
                        ),
                      ],
                    ),
                  if (!Responsive.isDesktop(context))
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          width: double.infinity,
                          child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                  Icons.person_outline_sharp),
                              label: const Text(
                                  'Modifiez vos informations')),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          width: double.infinity,
                          child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.password_outlined),
                              label: const Text(
                                  'Modifiez votre mot de passe')),
                        ),
                      ],
                    )
                ],
              ),
            ),
          )
          

    );
  }

  Widget header() {
    final headline3 = Theme.of(context).textTheme.headline3;
    final headline5 = Theme.of(context).textTheme.headline5;
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Responsive.isDesktop(context)
            ? Text('Mon Profil', style: headline3)
            : Text('Mon Profil', style: headline5),
      ),
    );
  }

  Widget profileItem(User userData) {
    final headline5 = Theme.of(context).textTheme.headline5;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    final bodyText2 = Theme.of(context).textTheme.bodyText2;
    return Responsive.isDesktop(context)
        ? ListBody(
            children: [
              Card(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text('Nom',
                      style: GoogleFonts.poppins(textStyle: headline5)),
                  trailing: Text(userData.firstName,
                      overflow: TextOverflow.clip,
                      style: GoogleFonts.poppins(
                          textStyle: headline5, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text('Post-Nom',
                      style: GoogleFonts.poppins(textStyle: headline5)),
                  trailing: Text(userData.lastName,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          textStyle: headline5, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text('UserName',
                      style: GoogleFonts.poppins(textStyle: headline5)),
                  trailing: Text(userData.userName,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          textStyle: headline5, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.email),
                  title: Text('Email',
                      style: GoogleFonts.poppins(textStyle: headline5)),
                  trailing: Text(userData.email,
                      overflow: TextOverflow.clip,
                      style: GoogleFonts.poppins(
                          textStyle: headline5, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.phone),
                  title: Text('T??l??phone',
                      style: GoogleFonts.poppins(textStyle: headline5)),
                  trailing: Text(userData.telephone,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          textStyle: headline5, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.location_city_rounded),
                  title: Text('Adresse',
                      style: GoogleFonts.poppins(textStyle: headline5)),
                  trailing: Text(userData.adresse,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          textStyle: headline5, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.play_arrow_rounded),
                  title: Text('Sexe',
                      style: GoogleFonts.poppins(textStyle: headline5)),
                  trailing: Text(userData.sexe,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          textStyle: headline5, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.play_arrow_rounded),
                  title: Text('Accr??ditation',
                      style: GoogleFonts.poppins(textStyle: headline5)),
                  trailing: Text(userData.role,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          textStyle: headline5, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.play_arrow_rounded),
                  title: Text('Campaign',
                      style: GoogleFonts.poppins(textStyle: headline5)),
                  trailing: Text(userData.campaign,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          textStyle: headline5, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.play_arrow_rounded),
                  title: Text('Superviseur',
                      style: GoogleFonts.poppins(textStyle: headline5)),
                  trailing: Text(userData.superviseur,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          textStyle: headline5, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.play_arrow_rounded),
                  title: Text('Statut',
                      style: GoogleFonts.poppins(textStyle: headline5)),
                  trailing: Text((userData.isOnline) ?
                      'Activ??' : 'D??sactiv??',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          textStyle: headline5, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.access_time_filled_sharp),
                  title: Text('Date de cr??ation',
                      style: GoogleFonts.poppins(textStyle: headline5)),
                  trailing: Text(
                      DateFormat("dd.MM.yy HH:mm").format(userData.createdAt),
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          textStyle: headline5, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CachedNetworkImage(
              //   imageUrl: userData.logo!,
              //   placeholder: (context, url) => const CircularProgressIndicator(),
              //   errorWidget: (context, url, error) => const Icon(Icons.error),
              // ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nom', style: bodyText2),
                        Text(userData.firstName,
                            overflow: TextOverflow.clip, style: bodyText1),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Post-Nom', style: bodyText2),
                        Text(userData.lastName,
                            overflow: TextOverflow.clip, style: bodyText1),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('UserName', style: bodyText2),
                        Text(userData.userName,
                            overflow: TextOverflow.clip, style: bodyText1),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email', style: bodyText2),
                        Text(userData.email,
                            overflow: TextOverflow.clip, style: bodyText1),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('T??l??phone', style: bodyText2),
                        Text(userData.telephone,
                            overflow: TextOverflow.clip, style: bodyText1),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Adresse', style: bodyText2),
                        Text(userData.adresse,
                            overflow: TextOverflow.clip, style: bodyText1),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sexe', style: bodyText2),
                        Text(userData.sexe,
                            overflow: TextOverflow.clip, style: bodyText1),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Accr??ditation', style: bodyText2),
                        Text(userData.role,
                            overflow: TextOverflow.clip, style: bodyText1),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Campaign', style: bodyText2),
                        Text(userData.campaign,
                            overflow: TextOverflow.clip, style: bodyText1),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Superviseur', style: bodyText2),
                        Text(userData.superviseur,
                            overflow: TextOverflow.clip,
                            style: bodyText1),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Statut', style: bodyText2),
                        Text((userData.isOnline) ? 'Activ??' : 'D??sactiv??',
                            overflow: TextOverflow.clip,
                            style: bodyText1),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date de cr??ation', style: bodyText2),
                        Text(
                            DateFormat("dd.MM.yy HH:mm")
                                .format(userData.createdAt),
                            overflow: TextOverflow.clip,
                            style: bodyText1),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          );
  }
}
