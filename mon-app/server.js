const http = require('http');

const server = http.createServer((req, res) => {
const http = require('http');
const { exec } = require('child_process');

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/html; charset=utf-8');

  // Exécute la commande Nmap pour scanner le réseau local
  exec('nmap -sn 192.168.1.0/24', (err, stdout, stderr) => {
    let output = err ? stderr : stdout;
    res.end(`
      <!DOCTYPE html>
      <html>
      <head>
        <title>Scanner Wi-Fi</title>
        <style>
          body { font-family: sans-serif; background: #121212; color: #fff; padding: 20px; }
          pre { background: #1e1e1e; padding: 15px; border-radius: 8px; color: #00ff88; overflow-x: auto; }
          button { padding: 10px 15px; background: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer; }
        </style>
      </head>
      <body>
        <h1>Réseau Wi-Fi - Appareils Connectés</h1>
        <button onclick="location.reload()">Rafraîchir le scan</button>
        <h2>Résultats du Scan :</h2>
        <pre>${output}</pre>
      </body>
      </html>
    `);
  });
});

server.listen(3000, () => {
  console.log('Scanner actif sur http://localhost:3000');
});
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/html; charset=utf-8');
  res.end('<h1>Bravo ! Mon serveur Node.js fonctionne sur Termux !</h1>');
});

server.listen(3000, () => {
  console.log('Serveur démarré sur http://localhost:3000');
});


