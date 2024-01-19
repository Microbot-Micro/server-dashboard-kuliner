const pool = require("../config/config.vercel");

class Controller {

    // getProduct with search
    static async getProduct(req, res, next) {
        try {
            const { search } = req.query;

            let query = 'SELECT * FROM "products"';
            if (search) {
                query += ` WHERE nama ILIKE '%${search}%'`; // Menggunakan ILIKE agar pencarian bersifat case-insensitive
            }

            const { rows } = await pool.query(query);
            res.status(200).json(rows);
        } catch (error) {
            console.error('Error in getProduct:', error);
            res.status(500).json({ error: 'Internal Server Error' });
        }
    }

    // getByIdProduct
    static async getByIdProduct(req, res, next) {
        try {
            const { id } = req.params;
            const query = 'SELECT * FROM "products" WHERE id = $1';
            const { rows } = await pool.query(query, [id]);

            if (rows.length > 0) {
                res.status(200).json(rows[0]);
            } else {
                res.status(404).json({ error: 'Product not found' });
            }
        } catch (error) {
            console.error('Error in getByIdProduct:', error);
            res.status(500).json({ error: 'Internal Server Error' });
        }
    }

    // postKeranjangs
    static async postKeranjangs(req, res, next) {
        try {
            const { jumlah_pesanan, keterangan, product_id } = req.body;

            if (jumlah_pesanan === "") {
                return res.status(400).json({ error: 'Pesanan tidak boleh kosong ' });
            }

            // Pastikan untuk mengganti "keranjangs" dan "product_id" sesuai dengan nama tabel dan kolom yang benar
            const existingProduct = await pool.query('SELECT * FROM "products" WHERE id = $1', [product_id]);

            if (existingProduct.rows.length === 0) {
                return res.status(404).json({ error: 'Product not found' });
            }

            const insertQuery = 'INSERT INTO "keranjangs" (jumlah_pesanan, keterangan, "product_id") VALUES ($1, $2, $3) RETURNING *';
            const values = [jumlah_pesanan, keterangan, product_id];

            const { rows } = await pool.query(insertQuery, values);

            res.status(200).json(rows[0]);
        } catch (error) {
            console.error('Error in postKeranjangs:', error);
            res.status(500).json({ error: 'Internal Server Error' });
        }
    }

    // getKeranjangs
    static async getKeranjangs(req, res, next) {
        try {
            const query = `
            SELECT
            keranjangs.id,
            keranjangs.jumlah_pesanan,
            keranjangs.keterangan,
            keranjangs.product_id AS productId,
            jsonb_build_object(
                'id', products.id,
                'kode', products.kode,
                'nama', products.nama,
                'harga', products.harga,
                'is_ready', products.is_ready,
                'gambar', products.gambar
            ) AS product
        FROM keranjangs
        INNER JOIN products ON keranjangs.product_id = products.id
        `;

            const { rows } = await pool.query(query);
            res.status(200).json(rows);
        } catch (error) {
            console.error('Error in getKeranjangs:', error);
            res.status(500).json({ error: 'Internal Server Error' });
        }
    }



    // deleteKeranjangs
    static async deleteKeranjangs(req, res, next) {
        try {
            const { id } = req.params;

            // Pastikan terlebih dahulu bahwa keranjang dengan ID yang diberikan ada
            const isValidIdQuery = 'SELECT * FROM keranjangs WHERE id = $1';
            const isValidIdResult = await pool.query(isValidIdQuery, [id]);

            if (isValidIdResult.rows.length === 0) {
                return res.status(400).json({ error: 'Invalid Request', message: `Data ${id} is not valid` });
            }

            const deleteKeranjangQuery = 'DELETE FROM keranjangs WHERE id = $1 RETURNING *';
            const { rows } = await pool.query(deleteKeranjangQuery, [id]);

            res.status(200).json({
                name: `Delete Data Keranjang ${id} Successfully`,
                deleteKeranjangQuery: rows
            });

        } catch (error) {
            console.error('Error in deleteKeranjangs:', error);
            res.status(500).json({ error: 'Internal Server Error' });
        }
    }

    // deleteAllKeranjangs
    static async deleteAllKeranjangs(req, res, next) {
        try {
            // Hapus semua data keranjang
            const deleteAllKeranjangsQuery = 'DELETE FROM keranjangs';
            const { rowCount } = await pool.query(deleteAllKeranjangsQuery);

            res.status(200).json({
                name: 'Delete All Data Keranjang Successfully',
                deletedCount: rowCount
            });
        } catch (error) {
            console.error('Error in deleteAllKeranjangs:', error);
            res.status(500).json({ error: 'Internal Server Error' });
        }
    }

    // postPesanans
    static async postPesanans(req, res, next) {
        try {
            const { nama, noMeja, keranjang_id } = req.body;

            // Periksa apakah pesanan dengan ID yang diberikan ada di keranjang
            const isValidPesanansQuery = 'SELECT * FROM keranjangs WHERE id = $1';
            const isValidPesanans = await pool.query(isValidPesanansQuery, [keranjang_id]);

            if (isValidPesanans.rows.length === 0) {
                return res.status(404).json({ error: 'Pesanan not found' });
            }

            // Tambahkan pesanan baru ke tabel pesanans
            const addPesananQuery = 'INSERT INTO pesanans (nama, noMeja, keranjang_id) VALUES ($1, $2, $3) RETURNING *';
            const { rows } = await pool.query(addPesananQuery, [nama, noMeja, keranjang_id]);

            res.status(200).json(rows[0]);

        } catch (error) {
            console.error('Error in postPesanans:', error);
            res.status(500).json({ error: 'Internal Server Error' });
        }
    }



}

module.exports = Controller;






