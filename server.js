const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());

const pool = new Pool({
  connectionString: process.env.DATABASE_URL || 'postgresql://postgres:password@localhost:5432/mre_livre_db',
  ssl: process.env.DATABASE_URL ? { rejectUnauthorized: false } : false
});

app.get('/', (req, res) => {
  res.json({ message: "API Mr E LIVRÉ & TRANSPORT (Multi-Apps Active)", status: "OK" });
});

// 1. Inscription & SMS OTP
app.post('/api/auth/register', async (req, res) => {
  const { full_name, phone, role } = req.body;
  res.json({ success: true, message: `Code SMS envoyé au ${phone}`, otp_demo: "4821" });
});

// 2. Soumission KYC Livreur
app.post('/api/driver/submit-kyc', (req, res) => {
  res.json({ success: true, message: "Dossier KYC reçu et en attente de validation Admin." });
});

// 3. Boutiques & Carte
app.get('/api/shops/map', (req, res) => {
  res.json({
    success: true,
    shops: [
      { id: "s1", name: "Boutique Assivito", lat: 6.1372, lng: 1.2125 },
      { id: "s2", name: "Alimentation Tokoin", lat: 6.1450, lng: 1.2180 }
    ]
  });
});

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => console.log(`🚀 Serveur Mr E actif sur le port ${PORT}`));
