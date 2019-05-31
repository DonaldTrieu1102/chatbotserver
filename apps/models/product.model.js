var db = require('../../utils/database');
function addProduct(entity){
    return db.add('sanpham', entity);
}
function deleteProduct(id){
    return db.delete('sanpham','MaSanPham', id);
}
module.exports = {
    all: () => {
        return db.excute('select * from sanpham');
    },
    findOne: (id) =>{
        return db.findOne('sanpham', 'MaSanPham', id);
    },
    findAllByIdCate: (idCate) =>{
        return db.excute('SELECT sanpham.MaSanPham, sanpham.MaDanhMuc, sanpham.Ten, sanpham.Gia, sanpham.TrangThai, khohang.Ten AS TenKhoHang, khohang.DiaChi  FROM sanpham, khohang WHERE sanpham.MaDanhMuc = '+ idCate +' AND sanpham.MaKhoHang = khohang.MaKhoHang;')
    },
    findById: (id) =>{
        return db.findById('sanpham', 'MaSanPham', id);
    },
    update: (entity) =>{
        return db.update('sanpham', 'MaSanPham', entity);
    },
    addProduct: addProduct,
    deleteProduct: deleteProduct
}