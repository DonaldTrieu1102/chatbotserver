/*
 Navicat Premium Data Transfer

 Source Server         : AthenaNails
 Source Server Type    : MySQL
 Source Server Version : 100309
 Source Host           : localhost:3306
 Source Schema         : manage-store

 Target Server Type    : MySQL
 Target Server Version : 100309
 File Encoding         : 65001

 Date: 31/05/2019 21:59:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for baidang
-- ----------------------------
DROP TABLE IF EXISTS `baidang`;
CREATE TABLE `baidang`  (
  `MaBaiDang` bigint(255) NOT NULL AUTO_INCREMENT,
  `TieuDe` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `NoiDung` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `DoiTuongSP` bigint(255) NULL DEFAULT NULL,
  `DoiTuongBaiViet` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NgayTao` datetime(6) NULL DEFAULT NULL,
  `NgayCapNhat` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`MaBaiDang`) USING BTREE,
  INDEX `DoiTuongSP`(`DoiTuongSP`) USING BTREE,
  CONSTRAINT `baidang_ibfk_1` FOREIGN KEY (`DoiTuongSP`) REFERENCES `danhmucsp` (`MaDanhMuc`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for baiquangcao
-- ----------------------------
DROP TABLE IF EXISTS `baiquangcao`;
CREATE TABLE `baiquangcao`  (
  `MaQC` bigint(255) NOT NULL AUTO_INCREMENT,
  `MaBaiDang` bigint(255) NULL DEFAULT NULL,
  `NgayBatDau` datetime(6) NULL DEFAULT NULL,
  `NgayKetThuc` datetime(6) NULL DEFAULT NULL,
  `CtyQuangCao` bigint(255) NULL DEFAULT NULL,
  `ThoiGianTao` datetime(6) NULL DEFAULT NULL,
  `ChiPhi` double(255, 0) NULL DEFAULT NULL,
  PRIMARY KEY (`MaQC`) USING BTREE,
  INDEX `MaBaiDang`(`MaBaiDang`) USING BTREE,
  INDEX `CtyQuangCao`(`CtyQuangCao`) USING BTREE,
  CONSTRAINT `baiquangcao_ibfk_1` FOREIGN KEY (`MaBaiDang`) REFERENCES `baidang` (`MaBaiDang`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `baiquangcao_ibfk_2` FOREIGN KEY (`CtyQuangCao`) REFERENCES `ctyquangcao` (`MaCty`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for banbe
-- ----------------------------
DROP TABLE IF EXISTS `banbe`;
CREATE TABLE `banbe`  (
  `MaBanBe` bigint(255) NOT NULL AUTO_INCREMENT,
  `MaFanpageKB` bigint(255) NULL DEFAULT NULL,
  `Ten` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DiaChiProfile` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`MaBanBe`) USING BTREE,
  INDEX `MaFanpageKB`(`MaFanpageKB`) USING BTREE,
  CONSTRAINT `banbe_ibfk_1` FOREIGN KEY (`MaFanpageKB`) REFERENCES `fanpagecuahang` (`MaFanPage`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for chitietbaidang
-- ----------------------------
DROP TABLE IF EXISTS `chitietbaidang`;
CREATE TABLE `chitietbaidang`  (
  `MaBaiDang` bigint(255) NOT NULL AUTO_INCREMENT,
  `LoaiSPQuangCao` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `LuotThich` bigint(255) NULL DEFAULT NULL,
  `LuotBinhLuan` bigint(255) NULL DEFAULT NULL,
  `LuotShare` bigint(255) NULL DEFAULT NULL,
  PRIMARY KEY (`MaBaiDang`) USING BTREE,
  CONSTRAINT `chitietbaidang_ibfk_1` FOREIGN KEY (`MaBaiDang`) REFERENCES `baidang` (`MaBaiDang`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for chitiethoadon
-- ----------------------------
DROP TABLE IF EXISTS `chitiethoadon`;
CREATE TABLE `chitiethoadon`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `MaHoaDon` bigint(255) NOT NULL,
  `MaSanPham` bigint(255) NULL DEFAULT NULL,
  `MaGiamGia` bigint(255) NULL DEFAULT NULL,
  `SoLuongSP` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `MaSanPham`(`MaSanPham`) USING BTREE,
  INDEX `MaHoaDon`(`MaHoaDon`) USING BTREE,
  CONSTRAINT `chitiethoadon_ibfk_1` FOREIGN KEY (`MaSanPham`) REFERENCES `sanpham` (`MaSanPham`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chitiethoadon_ibfk_2` FOREIGN KEY (`MaHoaDon`) REFERENCES `hoadon` (`MaHoaDon`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for chitietkhohang
-- ----------------------------
DROP TABLE IF EXISTS `chitietkhohang`;
CREATE TABLE `chitietkhohang`  (
  `manguonhang` bigint(255) NOT NULL AUTO_INCREMENT,
  `makhohang` bigint(255) NOT NULL,
  `ngaytaokho` datetime(6) NULL DEFAULT NULL,
  `ngaycapnhat` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`manguonhang`, `makhohang`) USING BTREE,
  INDEX `makhohang`(`makhohang`) USING BTREE,
  CONSTRAINT `chitietkhohang_ibfk_1` FOREIGN KEY (`manguonhang`) REFERENCES `nguonhang` (`MaNguonHang`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `chitietkhohang_ibfk_2` FOREIGN KEY (`makhohang`) REFERENCES `khohang` (`MaKhoHang`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for chitietsanpham
-- ----------------------------
DROP TABLE IF EXISTS `chitietsanpham`;
CREATE TABLE `chitietsanpham`  (
  `MaSanPham` bigint(255) NOT NULL,
  `TongSoLuong` bigint(255) NULL DEFAULT NULL,
  `TongTonKho` bigint(255) NULL DEFAULT NULL,
  `SoLuongCoTheBan` bigint(255) NULL DEFAULT NULL,
  `SoMauMa` int(255) NULL DEFAULT NULL,
  PRIMARY KEY (`MaSanPham`) USING BTREE,
  INDEX `MaSanPham`(`MaSanPham`) USING BTREE,
  CONSTRAINT `chitietsanpham_ibfk_1` FOREIGN KEY (`MaSanPham`) REFERENCES `sanpham` (`MaSanPham`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ctyquangcao
-- ----------------------------
DROP TABLE IF EXISTS `ctyquangcao`;
CREATE TABLE `ctyquangcao`  (
  `MaCty` bigint(255) NOT NULL AUTO_INCREMENT,
  `Ten` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DiaChiURL` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DiaChiThucTe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SDTChamSocKhachHang` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`MaCty`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for danhmucsp
-- ----------------------------
DROP TABLE IF EXISTS `danhmucsp`;
CREATE TABLE `danhmucsp`  (
  `MaDanhMuc` bigint(255) NOT NULL AUTO_INCREMENT,
  `TenDanhMuc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NgayTao` datetime(6) NULL DEFAULT NULL,
  `NgayCapNhat` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`MaDanhMuc`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of danhmucsp
-- ----------------------------
INSERT INTO `danhmucsp` VALUES (1, 'Thời trang nam', '2019-05-30 21:10:27.000000', '2019-05-30 21:10:44.000000');
INSERT INTO `danhmucsp` VALUES (2, 'Thời trang nữ', '2019-05-30 21:10:56.000000', '2019-05-30 21:10:59.000000');
INSERT INTO `danhmucsp` VALUES (3, 'Điện thoại và phụ kiện', '2019-05-30 21:11:16.000000', '2019-05-30 21:11:19.000000');
INSERT INTO `danhmucsp` VALUES (4, 'Mẹ và bé', '2019-05-30 21:11:33.000000', '2019-05-30 21:11:37.000000');

-- ----------------------------
-- Table structure for donvivanchuyen
-- ----------------------------
DROP TABLE IF EXISTS `donvivanchuyen`;
CREATE TABLE `donvivanchuyen`  (
  `MaDV` bigint(255) NOT NULL AUTO_INCREMENT,
  `Ten` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DiaChiURL` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DiaChiThucTe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`MaDV`) USING BTREE,
  INDEX `MaDV`(`MaDV`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of donvivanchuyen
-- ----------------------------
INSERT INTO `donvivanchuyen` VALUES (1, 'Giao hàng nhanh', 'giaohangnhanh.com.vn', '32 Đinh Tiên Hàng quận 1 TP HCM');

-- ----------------------------
-- Table structure for facebookfanpage
-- ----------------------------
DROP TABLE IF EXISTS `facebookfanpage`;
CREATE TABLE `facebookfanpage`  (
  `MaFBFanpage` bigint(255) NOT NULL AUTO_INCREMENT,
  `MaFanpage` bigint(255) NULL DEFAULT NULL,
  `SDTFanpage` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NgayTao` datetime(6) NULL DEFAULT NULL,
  `NgayCapNhat` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`MaFBFanpage`) USING BTREE,
  INDEX `facebookfanpage_ibfk_1`(`MaFanpage`) USING BTREE,
  CONSTRAINT `facebookfanpage_ibfk_1` FOREIGN KEY (`MaFanpage`) REFERENCES `fanpagecuahang` (`MaFanPage`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for fanpagecuahang
-- ----------------------------
DROP TABLE IF EXISTS `fanpagecuahang`;
CREATE TABLE `fanpagecuahang`  (
  `MaFanPage` bigint(255) NOT NULL AUTO_INCREMENT,
  `Ten` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DiaChiURL` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DiaChiThucTe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SoDienThoai` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`MaFanPage`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hoadon
-- ----------------------------
DROP TABLE IF EXISTS `hoadon`;
CREATE TABLE `hoadon`  (
  `MaHoaDon` bigint(255) NOT NULL AUTO_INCREMENT,
  `TenKhachHang` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DiaChiKhachHang` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SDTKhachHang` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `MaFanpage` bigint(255) NULL DEFAULT NULL,
  `TongGia` bigint(255) NULL DEFAULT NULL,
  `TrangThai` tinyint(5) NULL DEFAULT NULL,
  `MaGiamGia` bigint(255) NULL DEFAULT NULL,
  `ThoiGianTao` datetime(6) NULL DEFAULT NULL,
  `ThoiGianCapNhat` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`MaHoaDon`) USING BTREE,
  INDEX `MaGiamGia`(`MaGiamGia`) USING BTREE,
  INDEX `MaFanpage`(`MaFanpage`) USING BTREE,
  CONSTRAINT `hoadon_ibfk_2` FOREIGN KEY (`MaGiamGia`) REFERENCES `magiamgia` (`MaGiamGia`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `hoadon_ibfk_3` FOREIGN KEY (`MaFanpage`) REFERENCES `fanpagecuahang` (`MaFanPage`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hoadon
-- ----------------------------
INSERT INTO `hoadon` VALUES (3, 'awdadawdadad', 'adadadwadawd', '2342334', NULL, 400000, NULL, NULL, '2019-05-31 08:52:22.000000', NULL);
INSERT INTO `hoadon` VALUES (4, 'awdadlkajlwe a', '12adadadad', '23123', NULL, 0, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (5, 'awdawd', 'awdadw', 'awdawd', NULL, 100000, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (6, 'adawdadw', 'awdawd', 'qwd11', NULL, 0, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (7, 'awd', 'awd', '1', NULL, 900000, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (8, 'awdadw', 'adawd', '12123', NULL, 200000, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (9, 'awdadw', 'adawd', '12123', NULL, 200000, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (10, 'awdadw', 'adawd', '12123', NULL, 200000, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (11, 'awdadw', 'adawd', '12123', NULL, 200000, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (12, 'awdad', 'awdwd', 'awdawd', NULL, 2000000, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (15, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (18, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (19, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (22, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (23, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (24, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (26, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (27, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (28, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (29, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (31, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (33, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (35, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hoadon` VALUES (37, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for hoadonvanchuyen
-- ----------------------------
DROP TABLE IF EXISTS `hoadonvanchuyen`;
CREATE TABLE `hoadonvanchuyen`  (
  `MaHD` bigint(255) NOT NULL AUTO_INCREMENT,
  `TrongLuong` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `GiaCuoc` bigint(255) NULL DEFAULT NULL,
  `DiaChiGiaoHang` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `TrangThai` tinyint(5) NULL DEFAULT NULL,
  `DonViVanChuyen` bigint(255) NULL DEFAULT NULL,
  `NgayTao` datetime(6) NULL DEFAULT NULL,
  `MaKhoHang` bigint(255) NULL DEFAULT NULL,
  `NgayCapNhat` datetime(6) NULL DEFAULT NULL,
  `NgayGiaoXong` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`MaHD`) USING BTREE,
  INDEX `DonViVanChuyen`(`DonViVanChuyen`) USING BTREE,
  INDEX `MaKhoHang`(`MaKhoHang`) USING BTREE,
  CONSTRAINT `hoadonvanchuyen_ibfk_1` FOREIGN KEY (`DonViVanChuyen`) REFERENCES `donvivanchuyen` (`MaDV`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `hoadonvanchuyen_ibfk_2` FOREIGN KEY (`MaKhoHang`) REFERENCES `khohang` (`MaKhoHang`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for khohang
-- ----------------------------
DROP TABLE IF EXISTS `khohang`;
CREATE TABLE `khohang`  (
  `MaKhoHang` bigint(255) NOT NULL AUTO_INCREMENT,
  `Ten` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DiaChi` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NgayTao` datetime(0) NULL DEFAULT NULL,
  `NgayCapNhat` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`MaKhoHang`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for magiamgia
-- ----------------------------
DROP TABLE IF EXISTS `magiamgia`;
CREATE TABLE `magiamgia`  (
  `MaGiamGia` bigint(255) NOT NULL AUTO_INCREMENT,
  `TieuDe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `MieuTa` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `GiaGiam` double(255, 0) NULL DEFAULT NULL,
  `GiaHoaDonToiThieu` bigint(255) NULL DEFAULT NULL,
  `HanSuDung` datetime(6) NULL DEFAULT NULL,
  `NgayApDung` datetime(6) NULL DEFAULT NULL,
  `NgayTao` datetime(6) NULL DEFAULT NULL,
  `NgayCapNhat` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`MaGiamGia`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for nguoidung
-- ----------------------------
DROP TABLE IF EXISTS `nguoidung`;
CREATE TABLE `nguoidung`  (
  `MaTaiKhoan` bigint(255) NOT NULL AUTO_INCREMENT,
  `Ten` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DiaChi` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SoDienThoai` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `LanCuoiDangNhap` datetime(6) NULL DEFAULT NULL,
  `MaPhanQuyen` bigint(255) NULL DEFAULT NULL,
  `TheNganHang` bigint(255) NULL DEFAULT NULL,
  `NgayTao` datetime(6) NULL DEFAULT NULL,
  `NgayCapNhat` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`MaTaiKhoan`) USING BTREE,
  INDEX `TheNganHang`(`TheNganHang`) USING BTREE,
  INDEX `MaPhanQuyen`(`MaPhanQuyen`) USING BTREE,
  CONSTRAINT `nguoidung_ibfk_1` FOREIGN KEY (`TheNganHang`) REFERENCES `thenganhang` (`MaThe`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `nguoidung_ibfk_2` FOREIGN KEY (`MaPhanQuyen`) REFERENCES `phanquyennguoidung` (`MaPhanQuyenNguoiDung`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for nguonhang
-- ----------------------------
DROP TABLE IF EXISTS `nguonhang`;
CREATE TABLE `nguonhang`  (
  `MaNguonHang` bigint(255) NOT NULL AUTO_INCREMENT,
  `Ten` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `URLWebsite` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DiaChiThucTe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NguoiDungTen` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SoDienThoai` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `XuatXuHangHoa` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  ` NgayBatDauNhap` date NULL DEFAULT NULL,
  PRIMARY KEY (`MaNguonHang`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for phanquyennguoidung
-- ----------------------------
DROP TABLE IF EXISTS `phanquyennguoidung`;
CREATE TABLE `phanquyennguoidung`  (
  `MaPhanQuyenNguoiDung` bigint(255) NOT NULL AUTO_INCREMENT,
  `Ten` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NgayTao` datetime(6) NULL DEFAULT NULL,
  `NgayCapNhat` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`MaPhanQuyenNguoiDung`) USING BTREE,
  INDEX `MaPhanQuyenNguoiDung`(`MaPhanQuyenNguoiDung`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sanpham
-- ----------------------------
DROP TABLE IF EXISTS `sanpham`;
CREATE TABLE `sanpham`  (
  `MaSanPham` bigint(255) NOT NULL AUTO_INCREMENT,
  `MaKhoHang` bigint(255) NULL DEFAULT NULL,
  `MaDanhMuc` bigint(255) NULL DEFAULT NULL,
  `Ten` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Gia` bigint(255) NULL DEFAULT NULL,
  `TrangThai` tinyint(4) NULL DEFAULT NULL,
  `NgayTao` datetime(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  `NgayCapNhat` datetime(6) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`MaSanPham`) USING BTREE,
  INDEX `MaKhoHang`(`MaKhoHang`) USING BTREE,
  INDEX `MaDanhMuc`(`MaDanhMuc`) USING BTREE,
  CONSTRAINT `sanpham_ibfk_1` FOREIGN KEY (`MaKhoHang`) REFERENCES `khohang` (`MaKhoHang`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sanpham_ibfk_2` FOREIGN KEY (`MaDanhMuc`) REFERENCES `danhmucsp` (`MaDanhMuc`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sanphamcungcap
-- ----------------------------
DROP TABLE IF EXISTS `sanphamcungcap`;
CREATE TABLE `sanphamcungcap`  (
  `MaSanPham` bigint(255) NOT NULL AUTO_INCREMENT,
  `SLSanPhamCungCapToiThieu` bigint(255) NULL DEFAULT NULL,
  `Gia` bigint(255) NULL DEFAULT NULL,
  `DonViSanPham` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `HanSuDung` date NULL DEFAULT NULL,
  PRIMARY KEY (`MaSanPham`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sendofanpage
-- ----------------------------
DROP TABLE IF EXISTS `sendofanpage`;
CREATE TABLE `sendofanpage`  (
  `MaSDFB` bigint(255) NOT NULL AUTO_INCREMENT,
  `MaFB` bigint(255) NULL DEFAULT NULL,
  `SDTFanpage` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NgayTao` datetime(6) NULL DEFAULT NULL,
  `NgayCapNhat` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`MaSDFB`) USING BTREE,
  INDEX `MaFB`(`MaFB`) USING BTREE,
  CONSTRAINT `sendofanpage_ibfk_1` FOREIGN KEY (`MaFB`) REFERENCES `fanpagecuahang` (`MaFanPage`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for shoppefanpage
-- ----------------------------
DROP TABLE IF EXISTS `shoppefanpage`;
CREATE TABLE `shoppefanpage`  (
  `MaSPFB` bigint(255) NOT NULL AUTO_INCREMENT,
  `MaFB` bigint(255) NULL DEFAULT NULL,
  `SDT` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NgayTao` datetime(6) NULL DEFAULT NULL,
  `NgayCapNhat` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`MaSPFB`) USING BTREE,
  INDEX `MaFB`(`MaFB`) USING BTREE,
  CONSTRAINT `shoppefanpage_ibfk_1` FOREIGN KEY (`MaFB`) REFERENCES `fanpagecuahang` (`MaFanPage`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for spdacungcap
-- ----------------------------
DROP TABLE IF EXISTS `spdacungcap`;
CREATE TABLE `spdacungcap`  (
  `MaSanPham` bigint(255) NOT NULL AUTO_INCREMENT,
  `MaNhaCungCap` bigint(255) NOT NULL,
  `NgayCungCap` date NULL DEFAULT NULL,
  PRIMARY KEY (`MaSanPham`, `MaNhaCungCap`) USING BTREE,
  INDEX `MaNhaCungCap`(`MaNhaCungCap`) USING BTREE,
  CONSTRAINT `spdacungcap_ibfk_1` FOREIGN KEY (`MaSanPham`) REFERENCES `sanphamcungcap` (`MaSanPham`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `spdacungcap_ibfk_2` FOREIGN KEY (`MaNhaCungCap`) REFERENCES `nguonhang` (`MaNguonHang`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for thenganhang
-- ----------------------------
DROP TABLE IF EXISTS `thenganhang`;
CREATE TABLE `thenganhang`  (
  `MaThe` bigint(255) NOT NULL AUTO_INCREMENT,
  `IDThe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `MaNganHang` bigint(255) NULL DEFAULT NULL,
  `TenNganHang` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`MaThe`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for zalofanpage
-- ----------------------------
DROP TABLE IF EXISTS `zalofanpage`;
CREATE TABLE `zalofanpage`  (
  `ZaloFanPage` bigint(255) NOT NULL AUTO_INCREMENT,
  `MaFanpage` bigint(255) NULL DEFAULT NULL,
  `DiaChiURL` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `SDTFanpage` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NgayTao` datetime(6) NULL DEFAULT NULL,
  `NgayCapNhat` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`ZaloFanPage`) USING BTREE,
  INDEX `MaFanpage`(`MaFanpage`) USING BTREE,
  CONSTRAINT `zalofanpage_ibfk_1` FOREIGN KEY (`MaFanpage`) REFERENCES `fanpagecuahang` (`MaFanPage`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
