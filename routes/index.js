var express = require('express');
var  Controller = require('../controllers/product.controller');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

// Mendapatkan semua produk
router.get('/products', Controller.getProduct);

// // Mendapatkan produk berdasarkan ID
router.get('/products/:id', Controller.getByIdProduct);

// // Mendapatkan semua keranjang
router.get('/keranjangs', Controller.getKeranjangs);

// // Menambahkan item ke keranjang
router.post('/keranjangs', Controller.postKeranjangs);

// // Menghapus item dari keranjang
router.delete('/keranjangs/:id', Controller.deleteKeranjangs);

// // Menghapus item dari keranjang
router.delete('/keranjangs', Controller.deleteAllKeranjangs);

// // Menambahkan item ke keranjang
router.post('/pesanans', Controller.postPesanans);



module.exports = router;
