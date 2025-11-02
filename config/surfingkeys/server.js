import express from "express";
import https from "https";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();

// Serve static files in dist/
app.use(express.static(path.join(__dirname, "dist")));

app.get("/", (req, res) => {
  res.send("SurfingKeys HTTPS server is running.");
});

// HTTPS options
const options = {
  key: fs.readFileSync(path.join(__dirname, "certs/localhost.key")),
  cert: fs.readFileSync(path.join(__dirname, "certs/localhost.crt")),
};

// Start HTTPS server
https.createServer(options, app).listen(8999, () => {
  console.log("✅ HTTPS server running at https://localhost:8999");
  console.log("📦 Serving static files from ./dist/");
});
