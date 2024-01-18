'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Product extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      Product.hasMany(models.Keranjang,{
        foreignKey: 'productId',
      })
    }
  }
  Product.init({
    kode: DataTypes.STRING,
    nama: DataTypes.STRING,
    harga: DataTypes.INTEGER,
    is_ready: DataTypes.BOOLEAN,
    gambar: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'Product',
  });
  return Product;
};