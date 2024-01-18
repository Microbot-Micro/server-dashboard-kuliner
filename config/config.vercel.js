const { Pool } = require("pg");

const pool = new Pool({
  connectionString: process.env.POSTGRES_URL + "?sslmode=require",
});

// Penggunaan metode promise untuk menangani hasil query
pool.query("SELECT NOW()")
  .then(result => {
    console.log(result.rows);  // Menampilkan hasil query
  })
  .catch(error => {
    console.error("Error executing query:", error.message);  // Menampilkan pesan kesalahan
  })
  .finally(() => {
    pool.end();  // Menutup koneksi pool setelah selesai
  });

module.exports = pool;
