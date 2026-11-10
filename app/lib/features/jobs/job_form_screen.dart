import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../auth/auth_provider.dart';
import '../../l10n/app_localizations.dart';
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
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(_isEdit ? l.editJob : l.newJob)),
      body: _loading && _isEdit
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  TextFormField(
                    controller: _nameCtrl,
                    decoration: InputDecoration(labelText: l.jobName),
                    validator: (v) => v != null && v.trim().isNotEmpty
                        ? null
                        : l.requiredField,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _descCtrl,
                    decoration:
                        InputDecoration(labelText: l.description),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _addressCtrl,
                    decoration: InputDecoration(
                      labelText: l.address,
                      prefixIcon: const Icon(Icons.location_on),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _latCtrl,
                          decoration:
                              InputDecoration(labelText: l.latitude),
                          keyboardType:
                              const TextInputType.numberWithOptions(
                                  decimal: true, signed: true),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _lonCtrl,
                          decoration:
                              InputDecoration(labelText: l.longitude),
                          keyboardType:
                              const TextInputType.numberWithOptions(
                                  decimal: true, signed: true),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _geofenceCtrl,
                    decoration: InputDecoration(
                      labelText: l.geofenceRadius,
                      prefixIcon: const Icon(Icons.radar),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        int.tryParse(v ?? '') != null ? null : l.enterNumber,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _hoursCtrl,
                    decoration: InputDecoration(
                      labelText: l.estimatedHours,
                      prefixIcon: const Icon(Icons.schedule),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    // ignore: deprecated_member_use
                    value: _status,
                    decoration: InputDecoration(labelText: l.status),
                    items: [
                      DropdownMenuItem(
                          value: 'active', child: Text(l.statusActive)),
                      DropdownMenuItem(
                          value: 'paused', child: Text(l.statusPaused)),
                      DropdownMenuItem(
                          value: 'completed', child: Text(l.statusCompleted)),
                      DropdownMenuItem(
                          value: 'archived', child: Text(l.statusArchived)),
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
                        : Text(_isEdit ? l.saveChanges : l.createJob),
                  ),
                ],
              ),
            ),
    );
  }
}
