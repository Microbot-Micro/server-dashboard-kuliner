'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Pesanan extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  Pesanan.init({
    nama: DataTypes.STRING,
    noMeja: DataTypes.STRING,
    keranjangId: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'Pesanan',
  });
  return Pesanan;
};