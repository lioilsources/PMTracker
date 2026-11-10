// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Aika';

  @override
  String get navJobs => 'Työt';

  @override
  String get navRoster => 'Tiimi';

  @override
  String get navReports => 'Raportit';

  @override
  String get navAdmin => 'Ylläpito';

  @override
  String get retry => 'Yritä uudelleen';

  @override
  String get loginSubtitle => 'Työaikojen seuranta kohteissa';

  @override
  String get emailLabel => 'Sähköposti';

  @override
  String get emailInvalid => 'Anna kelvollinen sähköpostiosoite';

  @override
  String get passwordLabel => 'Salasana';

  @override
  String get passwordMin => 'Vähintään 6 merkkiä';

  @override
  String get signIn => 'Kirjaudu sisään';

  @override
  String get trackingTitle => 'Ajanseuranta';

  @override
  String greeting(String name) {
    return 'Hei, $name!';
  }

  @override
  String get ready => 'Valmis';

  @override
  String get onSite => 'Työmaalla';

  @override
  String get overrideBadge => 'Poikkeus';

  @override
  String get startShift => 'Aloita seuranta';

  @override
  String get stopShift => 'Lopeta seuranta';

  @override
  String get todayTotal => 'Tänään yhteensä';

  @override
  String get pickJob => 'Valitse työ';

  @override
  String get noAssignedActiveJob =>
      'Sinulle ei ole osoitettu yhtään aktiivista työtä';

  @override
  String get outsideGeofenceTitle => 'Geofencen ulkopuolella';

  @override
  String get outsideGeofenceBody =>
      'Et ole työkohteessa. Kirjoita syy, niin esihenkilö saa tiedon.';

  @override
  String get overrideReasonLabel => 'Poikkeuksen syy';

  @override
  String get cancel => 'Peruuta';

  @override
  String get startWithOverride => 'Aloita poikkeuksella';

  @override
  String get locationServicesOff => 'Sijaintipalvelut ovat pois päältä';

  @override
  String get locationDenied => 'Sijaintiin pääsy estetty';

  @override
  String get locationDeniedForever =>
      'Sijaintiin pääsy estetty pysyvästi — salli se asetuksissa';

  @override
  String get jobsTitle => 'Työt';

  @override
  String get newJob => 'Uusi työ';

  @override
  String get noJobs => 'Ei töitä';

  @override
  String get createJob => 'Luo työ';

  @override
  String plannedHours(String hours) {
    return '$hours h suunniteltu';
  }

  @override
  String get editJob => 'Muokkaa työtä';

  @override
  String get jobName => 'Työn nimi *';

  @override
  String get requiredField => 'Pakollinen kenttä';

  @override
  String get description => 'Kuvaus';

  @override
  String get address => 'Osoite';

  @override
  String get latitude => 'Leveysaste (lat)';

  @override
  String get longitude => 'Pituusaste (lon)';

  @override
  String get geofenceRadius => 'Geofencen säde (m)';

  @override
  String get enterNumber => 'Anna luku';

  @override
  String get estimatedHours => 'Arvioidut tunnit';

  @override
  String get status => 'Tila';

  @override
  String get statusActive => 'Aktiivinen';

  @override
  String get statusPaused => 'Tauolla';

  @override
  String get statusCompleted => 'Valmis';

  @override
  String get statusArchived => 'Arkistoitu';

  @override
  String get saveChanges => 'Tallenna muutokset';

  @override
  String get jobFallbackTitle => 'Työ';

  @override
  String get info => 'Tiedot';

  @override
  String get manager => 'Esihenkilö';

  @override
  String get geofence => 'Geofence';

  @override
  String get estimatedHoursShort => 'Arvioidut tunnit';

  @override
  String get addressUnset => 'Ei annettu';

  @override
  String get assignments => 'Osoitukset';

  @override
  String get add => 'Lisää';

  @override
  String errorWith(String error) {
    return 'Virhe: $error';
  }

  @override
  String get noAssignedMembers => 'Ei osoitettuja jäseniä';

  @override
  String get tasks => 'Tehtävät';

  @override
  String get noTasks => 'Ei tehtäviä';

  @override
  String get rosterTitle => 'Tiimini';

  @override
  String get noTeamMembers => 'Tiimissäsi ei ole jäseniä';

  @override
  String get askAdminAssign => 'Pyydä ylläpitäjää osoittamaan jäseniä';

  @override
  String get reportsTitle => 'Raportit';

  @override
  String get change => 'Muuta';

  @override
  String get noReportData => 'Valitulle ajanjaksolle ei ole tietoja';

  @override
  String totalLabel(String hours) {
    return 'Yhteensä: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h h $m min';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n merkintää',
      one: '$n merkintä',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Käyttäjähallinta';

  @override
  String get roleMember => 'Jäsen';

  @override
  String get roleManager => 'Esihenkilö';

  @override
  String get roleAdmin => 'Ylläpito';

  @override
  String get roleAdminFull => 'Ylläpitäjä';
}
