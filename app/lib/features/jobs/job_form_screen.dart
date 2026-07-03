import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../auth/auth_provider.dart';
import 'jobs_screen.dart';

class JobFormScreen extends ConsumerStatefulWidget {
  final String? jobId;
  const JobFormScreen({super.key, this.jobId});

  @override
  ConsumerState<JobFormScreen> createState() => _JobFormScreenState();
}

class _JobFormScreenState extends ConsumerState<JobFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _latCtrl = TextEditingController();
  final _lonCtrl = TextEditingController();
  final _geofenceCtrl = TextEditingController(text: '200');
  final _hoursCtrl = TextEditingController();
  String _status = 'active';
  bool _loading = false;
  bool _isEdit = false;

  @override
  void initState() {
    super.initState();
    _isEdit = widget.jobId != null;
    if (_isEdit) _loadJob();
  }

  Future<void> _loadJob() async {
    setState(() => _loading = true);
    final job = await Supabase.instance.client
        .from('jobs')
        .select()
        .eq('id', widget.jobId!)
        .single();
    _nameCtrl.text = job['name'] ?? '';
    _descCtrl.text = job['description'] ?? '';
    _addressCtrl.text = job['address'] ?? '';
    _latCtrl.text = job['lat']?.toString() ?? '';
    _lonCtrl.text = job['lng']?.toString() ?? '';
    _geofenceCtrl.text = job['geofence_radius_m']?.toString() ?? '200';
    _hoursCtrl.text = job['estimated_hours']?.toString() ?? '';
    _status = job['status'] ?? 'active';
    setState(() => _loading = false);
  }

  @override
  void dispose() {
    for (final c in [
      _nameCtrl,
      _descCtrl,
      _addressCtrl,
      _latCtrl,
      _lonCtrl,
      _geofenceCtrl,
      _hoursCtrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  /// Souřadnice: buď obě pole, nebo žádné; hodnota v platném rozsahu.
  String? _validateCoord(
      String? value, String otherValue, double maxAbs, String label) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return otherValue.trim().isEmpty ? null : 'Vyplňte obě souřadnice';
    }
    final parsed = double.tryParse(text);
    if (parsed == null || parsed.abs() > maxAbs) {
      return 'Zadejte $label v rozsahu ±${maxAbs.toInt()}';
    }
    return null;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    final profile = await ref.read(currentProfileProvider.future);
    final companyId = profile?['company_id'] as String?;
    final userId = Supabase.instance.client.auth.currentUser?.id;

    final data = <String, dynamic>{
      'name': _nameCtrl.text.trim(),
      'description': _descCtrl.text.trim().isEmpty
          ? null
          : _descCtrl.text.trim(),
      'address': _addressCtrl.text.trim().isEmpty
          ? null
          : _addressCtrl.text.trim(),
      'geofence_radius_m': int.tryParse(_geofenceCtrl.text) ?? 200,
      'estimated_hours': _hoursCtrl.text.trim().isEmpty
          ? null
          : double.tryParse(_hoursCtrl.text),
      'status': _status,
    };

    // Poloha: WKT string PostgREST převede na geography.
    // Server pak geofence ověřuje proti jobs.location.
    final lat = double.tryParse(_latCtrl.text.trim());
    final lon = double.tryParse(_lonCtrl.text.trim());
    data['location'] =
        (lat != null && lon != null) ? 'SRID=4326;POINT($lon $lat)' : null;

    try {
      if (_isEdit) {
        await Supabase.instance.client
            .from('jobs')
            .update(data)
            .eq('id', widget.jobId!);
      } else {
        data['company_id'] = companyId;
        data['manager_id'] = userId;
        await Supabase.instance.client.from('jobs').insert(data);
      }
      if (mounted) {
        ref.invalidate(allJobsProvider);
        context.pop();
      }
    } on PostgrestException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(_isEdit ? 'Upravit zakázku' : 'Nová zakázka')),
      body: _loading && _isEdit
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  TextFormField(
                    controller: _nameCtrl,
                    decoration: const InputDecoration(
                        labelText: 'Název zakázky *'),
                    validator: (v) => v != null && v.trim().isNotEmpty
                        ? null
                        : 'Povinné pole',
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _descCtrl,
                    decoration:
                        const InputDecoration(labelText: 'Popis'),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _addressCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Adresa',
                      prefixIcon: Icon(Icons.location_on),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _latCtrl,
                          decoration: const InputDecoration(
                              labelText: 'Zeměpisná šířka (lat)'),
                          keyboardType:
                              const TextInputType.numberWithOptions(
                                  decimal: true, signed: true),
                          validator: (v) => _validateCoord(
                              v, _lonCtrl.text, 90, 'šířku'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _lonCtrl,
                          decoration: const InputDecoration(
                              labelText: 'Zeměpisná délka (lon)'),
                          keyboardType:
                              const TextInputType.numberWithOptions(
                                  decimal: true, signed: true),
                          validator: (v) => _validateCoord(
                              v, _latCtrl.text, 180, 'délku'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _geofenceCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Geofence poloměr (m)',
                      prefixIcon: Icon(Icons.radar),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        int.tryParse(v ?? '') != null ? null : 'Zadejte číslo',
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _hoursCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Odhadované hodiny',
                      prefixIcon: Icon(Icons.schedule),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    // ignore: deprecated_member_use
                    value: _status,
                    decoration:
                        const InputDecoration(labelText: 'Stav'),
                    items: const [
                      DropdownMenuItem(
                          value: 'active', child: Text('Aktivní')),
                      DropdownMenuItem(
                          value: 'paused', child: Text('Pozastavena')),
                      DropdownMenuItem(
                          value: 'completed', child: Text('Dokončena')),
                      DropdownMenuItem(
                          value: 'archived', child: Text('Archiv')),
                    ],
                    onChanged: (v) => setState(() => _status = v!),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _loading ? null : _save,
                    child: _loading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(_isEdit
                            ? 'Uložit změny'
                            : 'Vytvořit zakázku'),
                  ),
                ],
              ),
            ),
    );
  }
}
