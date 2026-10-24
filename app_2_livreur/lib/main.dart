import 'package:flutter/material.dart';

void main() {
  runApp(const MrELivreurApp());
}

class MrELivreurApp extends StatelessWidget {
  const MrELivreurApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mr E - Application Livreur & Conducteur',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E3A8A)),
        useMaterial3: true,
      ),
      home: const LivreurKYCScreen(),
    );
  }
}

class LivreurKYCScreen extends StatefulWidget {
  const LivreurKYCScreen({Key? key}) : super(key: key);

  @override
  State<LivreurKYCScreen> createState() => _LivreurKYCScreenState();
}

class _LivreurKYCScreenState extends State<LivreurKYCScreen> {
  final _cniController = TextEditingController();
  final _immatController = TextEditingController();
  bool _submittedKYC = false;
  bool _isOnline = false;

  @override
  Widget build(BuildContext context) {
    if (_submittedKYC) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Espace Livreur (Vérifié)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xFF1E3A8A),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SwitchListTile(
                title: Text(_isOnline ? 'STATUT : EN LIGNE' : 'STATUT : HORS LIGNE',
                    style: TextStyle(fontWeight: FontWeight.bold, color: _isOnline ? Colors.green : Colors.red)),
                value: _isOnline,
                activeColor: Colors.green,
                onChanged: (v) => setState(() => _isOnline = v),
              ),
              const Divider(),
              const SizedBox(height: 10),
              const Text('Livraisons & Courses Disponibles à Lomé',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.two_wheeler, color: Colors.blue, size: 36),
                  title: const Text('Livraison : Assivito ➔ Tokoin', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('Gain : 1 500 FCFA'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Course acceptée ! Navigation GPS démarrée.')),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                    child: const Text('Accepter'),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription Livreur - Vérification KYC', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Vérification d\'identité obligatoire (KYC)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
            const SizedBox(height: 10),
            const Text('Pour la sécurité de nos clients à Lomé, merci de fournir vos informations officielles.'),
            const SizedBox(height: 20),
            TextField(
              controller: _cniController,
              decoration: const InputDecoration(labelText: 'Numéro CNI / Passeport', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _immatController,
              decoration: const InputDecoration(labelText: 'Plaque d\'immatriculation du véhicule', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Documents CNI / Permis chargés.')),
                );
              },
              icon: const Icon(Icons.upload_file),
              label: const Text('Téléverser CNI / Permis / Carte Grise'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (_cniController.text.isNotEmpty) {
                  setState(() => _submittedKYC = true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Veuillez remplir le numéro CNI.')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size.fromHeight(50)),
              child: const Text('Soumettre le dossier KYC à l\'Admin', style: TextStyle(color: Colors.white, fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}
