// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Ponto';

  @override
  String get navJobs => 'Obras';

  @override
  String get navRoster => 'Equipe';

  @override
  String get navReports => 'Relatórios';

  @override
  String get navAdmin => 'Admin';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get loginSubtitle => 'Registro de horas nas obras';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get emailInvalid => 'Informe um e-mail válido';

  @override
  String get passwordLabel => 'Senha';

  @override
  String get passwordMin => 'Mínimo de 6 caracteres';

  @override
  String get signIn => 'Entrar';

  @override
  String get trackingTitle => 'Registro de horas';

  @override
  String greeting(String name) {
    return 'Olá, $name!';
  }

  @override
  String get ready => 'Pronto';

  @override
  String get onSite => 'No local';

  @override
  String get overrideBadge => 'Exceção';

  @override
  String get startShift => 'Iniciar registro';

  @override
  String get stopShift => 'Encerrar registro';

  @override
  String get todayTotal => 'Total de hoje';

  @override
  String get pickJob => 'Escolha uma obra';

  @override
  String get noAssignedActiveJob =>
      'Você não está atribuído a nenhuma obra ativa';

  @override
  String get outsideGeofenceTitle => 'Fora da geocerca';

  @override
  String get outsideGeofenceBody =>
      'Você não está no local da obra. Informe o motivo e o gerente será avisado.';

  @override
  String get overrideReasonLabel => 'Motivo da exceção';

  @override
  String get cancel => 'Cancelar';

  @override
  String get startWithOverride => 'Iniciar com exceção';

  @override
  String get locationServicesOff =>
      'Os serviços de localização estão desativados';

  @override
  String get locationDenied => 'Acesso à localização negado';

  @override
  String get locationDeniedForever =>
      'Acesso à localização negado permanentemente — permita nos ajustes';

  @override
  String get jobsTitle => 'Obras';

  @override
  String get newJob => 'Nova obra';

  @override
  String get noJobs => 'Nenhuma obra';

  @override
  String get createJob => 'Criar obra';

  @override
  String plannedHours(String hours) {
    return '$hours h previstas';
  }

  @override
  String get editJob => 'Editar obra';

  @override
  String get jobName => 'Nome da obra *';

  @override
  String get requiredField => 'Campo obrigatório';

  @override
  String get description => 'Descrição';

  @override
  String get address => 'Endereço';

  @override
  String get latitude => 'Latitude (lat)';

  @override
  String get longitude => 'Longitude (lon)';

  @override
  String get geofenceRadius => 'Raio da geocerca (m)';

  @override
  String get enterNumber => 'Informe um número';

  @override
  String get estimatedHours => 'Horas estimadas';

  @override
  String get status => 'Status';

  @override
  String get statusActive => 'Ativa';

  @override
  String get statusPaused => 'Pausada';

  @override
  String get statusCompleted => 'Concluída';

  @override
  String get statusArchived => 'Arquivada';

  @override
  String get saveChanges => 'Salvar alterações';

  @override
  String get jobFallbackTitle => 'Obra';

  @override
  String get info => 'Informações';

  @override
  String get manager => 'Gerente';

  @override
  String get geofence => 'Geocerca';

  @override
  String get estimatedHoursShort => 'Horas estimadas';

  @override
  String get addressUnset => 'Não informado';

  @override
  String get assignments => 'Atribuições';

  @override
  String get add => 'Adicionar';

  @override
  String errorWith(String error) {
    return 'Erro: $error';
  }

  @override
  String get noAssignedMembers => 'Nenhum membro atribuído';

  @override
  String get tasks => 'Tarefas';

  @override
  String get noTasks => 'Nenhuma tarefa';

  @override
  String get rosterTitle => 'Minha equipe';

  @override
  String get noTeamMembers => 'Você não tem membros na equipe';

  @override
  String get askAdminAssign => 'Peça a um administrador para atribuir membros';

  @override
  String get reportsTitle => 'Relatórios';

  @override
  String get change => 'Alterar';

  @override
  String get noReportData => 'Sem dados para o período selecionado';

  @override
  String totalLabel(String hours) {
    return 'Total: $hours';
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
      other: '$n registros',
      one: '$n registro',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Gerenciamento de usuários';

  @override
  String get roleMember => 'Membro';

  @override
  String get roleManager => 'Gerente';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleAdminFull => 'Administrador';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Ponto';

  @override
  String get navJobs => 'Obras';

  @override
  String get navRoster => 'Equipe';

  @override
  String get navReports => 'Relatórios';

  @override
  String get navAdmin => 'Admin';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get loginSubtitle => 'Registro de horas nas obras';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get emailInvalid => 'Informe um e-mail válido';

  @override
  String get passwordLabel => 'Senha';

  @override
  String get passwordMin => 'Mínimo de 6 caracteres';

  @override
  String get signIn => 'Entrar';

  @override
  String get trackingTitle => 'Registro de horas';

  @override
  String greeting(String name) {
    return 'Olá, $name!';
  }

  @override
  String get ready => 'Pronto';

  @override
  String get onSite => 'No local';

  @override
  String get overrideBadge => 'Exceção';

  @override
  String get startShift => 'Iniciar registro';

  @override
  String get stopShift => 'Encerrar registro';

  @override
  String get todayTotal => 'Total de hoje';

  @override
  String get pickJob => 'Escolha uma obra';

  @override
  String get noAssignedActiveJob =>
      'Você não está atribuído a nenhuma obra ativa';

  @override
  String get outsideGeofenceTitle => 'Fora da geocerca';

  @override
  String get outsideGeofenceBody =>
      'Você não está no local da obra. Informe o motivo e o gerente será avisado.';

  @override
  String get overrideReasonLabel => 'Motivo da exceção';

  @override
  String get cancel => 'Cancelar';

  @override
  String get startWithOverride => 'Iniciar com exceção';

  @override
  String get locationServicesOff =>
      'Os serviços de localização estão desativados';

  @override
  String get locationDenied => 'Acesso à localização negado';

  @override
  String get locationDeniedForever =>
      'Acesso à localização negado permanentemente — permita nos ajustes';

  @override
  String get jobsTitle => 'Obras';

  @override
  String get newJob => 'Nova obra';

  @override
  String get noJobs => 'Nenhuma obra';

  @override
  String get createJob => 'Criar obra';

  @override
  String plannedHours(String hours) {
    return '$hours h previstas';
  }

  @override
  String get editJob => 'Editar obra';

  @override
  String get jobName => 'Nome da obra *';

  @override
  String get requiredField => 'Campo obrigatório';

  @override
  String get description => 'Descrição';

  @override
  String get address => 'Endereço';

  @override
  String get latitude => 'Latitude (lat)';

  @override
  String get longitude => 'Longitude (lon)';

  @override
  String get geofenceRadius => 'Raio da geocerca (m)';

  @override
  String get enterNumber => 'Informe um número';

  @override
  String get estimatedHours => 'Horas estimadas';

  @override
  String get status => 'Status';

  @override
  String get statusActive => 'Ativa';

  @override
  String get statusPaused => 'Pausada';

  @override
  String get statusCompleted => 'Concluída';

  @override
  String get statusArchived => 'Arquivada';

  @override
  String get saveChanges => 'Salvar alterações';

  @override
  String get jobFallbackTitle => 'Obra';

  @override
  String get info => 'Informações';

  @override
  String get manager => 'Gerente';

  @override
  String get geofence => 'Geocerca';

  @override
  String get estimatedHoursShort => 'Horas estimadas';

  @override
  String get addressUnset => 'Não informado';

  @override
  String get assignments => 'Atribuições';

  @override
  String get add => 'Adicionar';

  @override
  String errorWith(String error) {
    return 'Erro: $error';
  }

  @override
  String get noAssignedMembers => 'Nenhum membro atribuído';

  @override
  String get tasks => 'Tarefas';

  @override
  String get noTasks => 'Nenhuma tarefa';

  @override
  String get rosterTitle => 'Minha equipe';

  @override
  String get noTeamMembers => 'Você não tem membros na equipe';

  @override
  String get askAdminAssign => 'Peça a um administrador para atribuir membros';

  @override
  String get reportsTitle => 'Relatórios';

  @override
  String get change => 'Alterar';

  @override
  String get noReportData => 'Sem dados para o período selecionado';

  @override
  String totalLabel(String hours) {
    return 'Total: $hours';
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
      other: '$n registros',
      one: '$n registro',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Gerenciamento de usuários';

  @override
  String get roleMember => 'Membro';

  @override
  String get roleManager => 'Gerente';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleAdminFull => 'Administrador';
}

/// The translations for Portuguese, as used in Portugal (`pt_PT`).
class AppLocalizationsPtPt extends AppLocalizationsPt {
  AppLocalizationsPtPt() : super('pt_PT');

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Registo';

  @override
  String get navJobs => 'Obras';

  @override
  String get navRoster => 'Equipa';

  @override
  String get navReports => 'Relatórios';

  @override
  String get navAdmin => 'Admin';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get loginSubtitle => 'Registo de horas nas obras';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get emailInvalid => 'Introduza um e-mail válido';

  @override
  String get passwordLabel => 'Palavra-passe';

  @override
  String get passwordMin => 'Mínimo de 6 caracteres';

  @override
  String get signIn => 'Iniciar sessão';

  @override
  String get trackingTitle => 'Registo de horas';

  @override
  String greeting(String name) {
    return 'Olá, $name!';
  }

  @override
  String get ready => 'Pronto';

  @override
  String get onSite => 'No local';

  @override
  String get overrideBadge => 'Exceção';

  @override
  String get startShift => 'Iniciar registo';

  @override
  String get stopShift => 'Terminar registo';

  @override
  String get todayTotal => 'Total de hoje';

  @override
  String get pickJob => 'Escolha uma obra';

  @override
  String get noAssignedActiveJob => 'Não tem nenhuma obra ativa atribuída';

  @override
  String get outsideGeofenceTitle => 'Fora da geovedação';

  @override
  String get outsideGeofenceBody =>
      'Não está no local da obra. Indique o motivo e o responsável será informado.';

  @override
  String get overrideReasonLabel => 'Motivo da exceção';

  @override
  String get cancel => 'Cancelar';

  @override
  String get startWithOverride => 'Iniciar com exceção';

  @override
  String get locationServicesOff =>
      'Os serviços de localização estão desativados';

  @override
  String get locationDenied => 'Acesso à localização recusado';

  @override
  String get locationDeniedForever =>
      'Acesso à localização recusado de forma permanente — permita nas definições';

  @override
  String get jobsTitle => 'Obras';

  @override
  String get newJob => 'Nova obra';

  @override
  String get noJobs => 'Nenhuma obra';

  @override
  String get createJob => 'Criar obra';

  @override
  String plannedHours(String hours) {
    return '$hours h previstas';
  }

  @override
  String get editJob => 'Editar obra';

  @override
  String get jobName => 'Nome da obra *';

  @override
  String get requiredField => 'Campo obrigatório';

  @override
  String get description => 'Descrição';

  @override
  String get address => 'Morada';

  @override
  String get latitude => 'Latitude (lat)';

  @override
  String get longitude => 'Longitude (lon)';

  @override
  String get geofenceRadius => 'Raio da geovedação (m)';

  @override
  String get enterNumber => 'Introduza um número';

  @override
  String get estimatedHours => 'Horas estimadas';

  @override
  String get status => 'Estado';

  @override
  String get statusActive => 'Ativa';

  @override
  String get statusPaused => 'Em pausa';

  @override
  String get statusCompleted => 'Concluída';

  @override
  String get statusArchived => 'Arquivada';

  @override
  String get saveChanges => 'Guardar alterações';

  @override
  String get jobFallbackTitle => 'Obra';

  @override
  String get info => 'Informações';

  @override
  String get manager => 'Responsável';

  @override
  String get geofence => 'Geovedação';

  @override
  String get estimatedHoursShort => 'Horas estimadas';

  @override
  String get addressUnset => 'Não indicada';

  @override
  String get assignments => 'Atribuições';

  @override
  String get add => 'Adicionar';

  @override
  String errorWith(String error) {
    return 'Erro: $error';
  }

  @override
  String get noAssignedMembers => 'Nenhum membro atribuído';

  @override
  String get tasks => 'Tarefas';

  @override
  String get noTasks => 'Nenhuma tarefa';

  @override
  String get rosterTitle => 'A minha equipa';

  @override
  String get noTeamMembers => 'Não tem membros na equipa';

  @override
  String get askAdminAssign => 'Peça a um administrador para atribuir membros';

  @override
  String get reportsTitle => 'Relatórios';

  @override
  String get change => 'Alterar';

  @override
  String get noReportData => 'Sem dados para o período selecionado';

  @override
  String totalLabel(String hours) {
    return 'Total: $hours';
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
      other: '$n registos',
      one: '$n registo',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Gestão de utilizadores';

  @override
  String get roleMember => 'Membro';

  @override
  String get roleManager => 'Responsável';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleAdminFull => 'Administrador';
}
