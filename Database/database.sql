

USE master;
GO

IF DB_ID(N'QUANLYKHACHSANKimAnh') IS NOT NULL
BEGIN
    ALTER DATABASE QUANLYKHACHSANKimAnh SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE QUANLYKHACHSANKimAnh;
END
GO

CREATE DATABASE QUANLYKHACHSANKimAnh;
GO

USE QUANLYKHACHSANKimAnh;
GO

/* ---------------------------------------------------------------------
   1. NGUOIDUNG  (Form: Dang nhap, Quan ly tai khoan, Doi mat khau)
   Quyen: 'Admin' hoac 'NhanVien'
   MatKhau luu dang ma hoa SHA-256 (chuoi hex 64 ky tu, chu HOA)
   --------------------------------------------------------------------- */
CREATE TABLE NGUOIDUNG (
    TenDangNhap VARCHAR(50)   NOT NULL PRIMARY KEY,
    MatKhau     VARCHAR(64)   NOT NULL,
    HoTen       NVARCHAR(100) NOT NULL,
    Quyen       VARCHAR(20)   NOT NULL DEFAULT 'NhanVien'
                CHECK (Quyen IN ('Admin', 'NhanVien')),
    TrangThai   BIT           NOT NULL DEFAULT 1   -- 1: hoat dong, 0: khoa
);
GO

/* ---------------------------------------------------------------------
   2. LOAI_PHONG  (Form: Quan ly loai phong)
   --------------------------------------------------------------------- */
CREATE TABLE LOAI_PHONG (
    MaLoaiPhong  VARCHAR(10)   NOT NULL PRIMARY KEY,
    TenLoaiPhong NVARCHAR(50)  NOT NULL,
    DonGia       DECIMAL(18,0) NOT NULL CHECK (DonGia >= 0),      -- gia / dem
    SoNguoiToiDa INT           NOT NULL DEFAULT 2 CHECK (SoNguoiToiDa > 0),
    MoTa         NVARCHAR(200) NULL
);
GO

/* ---------------------------------------------------------------------
   3. PHONG  (Form: Quan ly phong, kem cot tinh trang)
   TinhTrang: 'Trong' | 'DaDat' | 'DangO' | 'DangDon'
   --------------------------------------------------------------------- */
CREATE TABLE PHONG (
    MaPhong     VARCHAR(10)  NOT NULL PRIMARY KEY,
    TenPhong    NVARCHAR(50) NOT NULL,
    MaLoaiPhong VARCHAR(10)  NOT NULL,
    Tang        INT          NULL,
    TinhTrang   VARCHAR(10)  NOT NULL DEFAULT 'Trong'
                CHECK (TinhTrang IN ('Trong', 'DaDat', 'DangO', 'DangDon')),
    GhiChu      NVARCHAR(200) NULL,
    CONSTRAINT FK_PHONG_LOAIPHONG FOREIGN KEY (MaLoaiPhong)
        REFERENCES LOAI_PHONG(MaLoaiPhong)
);
GO

/* ---------------------------------------------------------------------
   4. DICHVU  (Form: Quan ly dich vu)
   --------------------------------------------------------------------- */
CREATE TABLE DICHVU (
    MaDV       VARCHAR(10)   NOT NULL PRIMARY KEY,
    TenDV      NVARCHAR(100) NOT NULL,
    DonGia     DECIMAL(18,0) NOT NULL CHECK (DonGia >= 0),
    DonViTinh  NVARCHAR(20)  NULL
);
GO

/* ---------------------------------------------------------------------
   5. KHACHHANG  (Form: Quan ly khach hang)
   --------------------------------------------------------------------- */
CREATE TABLE KHACHHANG (
    MaKH     INT IDENTITY(1,1) PRIMARY KEY,
    HoTen    NVARCHAR(100) NOT NULL,
    CCCD     VARCHAR(20)   NOT NULL UNIQUE,
    GioiTinh NVARCHAR(5)   NULL,
    NgaySinh DATE          NULL,
    SDT      VARCHAR(15)   NULL,
    DiaChi   NVARCHAR(200) NULL
);
GO

/* ---------------------------------------------------------------------
   6. PHIEUDAT  (Form: Dat phong, kem danh sach phieu dat)
   TrangThai: 'DaDat' | 'DaNhan' | 'Huy'
   --------------------------------------------------------------------- */
CREATE TABLE PHIEUDAT (
    MaPhieuDat   INT IDENTITY(1,1) PRIMARY KEY,
    MaKH         INT           NOT NULL,
    MaPhong      VARCHAR(10)   NOT NULL,
    NgayDat      DATETIME      NOT NULL DEFAULT GETDATE(),
    NgayDen      DATE          NOT NULL,
    NgayDiDuKien DATE          NOT NULL,
    TienCoc      DECIMAL(18,0) NOT NULL DEFAULT 0 CHECK (TienCoc >= 0),
    TrangThai    VARCHAR(10)   NOT NULL DEFAULT 'DaDat'
                 CHECK (TrangThai IN ('DaDat', 'DaNhan', 'Huy')),
    GhiChu       NVARCHAR(200) NULL,
    CONSTRAINT FK_PHIEUDAT_KH    FOREIGN KEY (MaKH)    REFERENCES KHACHHANG(MaKH),
    CONSTRAINT FK_PHIEUDAT_PHONG FOREIGN KEY (MaPhong) REFERENCES PHONG(MaPhong),
    CONSTRAINT CK_PHIEUDAT_NGAY  CHECK (NgayDiDuKien > NgayDen)
);
GO

/* ---------------------------------------------------------------------
   7. PHIEUNHAN  (Form: Nhan phong)
   MaPhieuDat co the NULL (khach vang lai, nhan phong khong dat truoc)
   TrangThai: 'DangO' | 'DaTra'
   --------------------------------------------------------------------- */
CREATE TABLE PHIEUNHAN (
    MaPhieuNhan   INT IDENTITY(1,1) PRIMARY KEY,
    MaPhieuDat    INT           NULL,
    MaKH          INT           NOT NULL,
    MaPhong       VARCHAR(10)   NOT NULL,
    NgayNhan      DATETIME      NOT NULL DEFAULT GETDATE(),
    NgayTraDuKien DATE          NOT NULL,
    NgayTraThucTe DATETIME      NULL,
    TrangThai     VARCHAR(10)   NOT NULL DEFAULT 'DangO'
                  CHECK (TrangThai IN ('DangO', 'DaTra')),
    CONSTRAINT FK_PHIEUNHAN_PHIEUDAT FOREIGN KEY (MaPhieuDat) REFERENCES PHIEUDAT(MaPhieuDat),
    CONSTRAINT FK_PHIEUNHAN_KH       FOREIGN KEY (MaKH)       REFERENCES KHACHHANG(MaKH),
    CONSTRAINT FK_PHIEUNHAN_PHONG    FOREIGN KEY (MaPhong)    REFERENCES PHONG(MaPhong)
);
GO
CREATE UNIQUE INDEX UX_PHIEUNHAN_PHONG_DANGO
ON PHIEUNHAN(MaPhong) WHERE TrangThai = 'DangO';
GO

/* ---------------------------------------------------------------------
   8. SUDUNGDICHVU  (Form: Su dung dich vu)
   DonGia luu lai gia luc dung (de sau nay doi gia dich vu khong lam
   sai hoa don cu)
   --------------------------------------------------------------------- */
CREATE TABLE SUDUNGDICHVU (
    MaSD        INT IDENTITY(1,1) PRIMARY KEY,
    MaPhieuNhan INT           NOT NULL,
    MaDV        VARCHAR(10)   NOT NULL,
    SoLuong     INT           NOT NULL CHECK (SoLuong > 0),
    DonGia      DECIMAL(18,0) NOT NULL CHECK (DonGia >= 0),
    NgaySuDung  DATETIME      NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_SDDV_PHIEUNHAN FOREIGN KEY (MaPhieuNhan) REFERENCES PHIEUNHAN(MaPhieuNhan),
    CONSTRAINT FK_SDDV_DICHVU    FOREIGN KEY (MaDV)        REFERENCES DICHVU(MaDV)
);
GO

/* ---------------------------------------------------------------------
   9. HOADON  (Form: Tra phong va thanh toan, kem danh sach hoa don)
   TongTien = TienPhong + TienDichVu - TienCoc
   --------------------------------------------------------------------- */
CREATE TABLE HOADON (
    MaHoaDon    INT IDENTITY(1,1) PRIMARY KEY,
    MaPhieuNhan INT           NOT NULL UNIQUE,      -- 1 phieu nhan = 1 hoa don
    NgayLap     DATETIME      NOT NULL DEFAULT GETDATE(),
    SoDem       INT           NOT NULL CHECK (SoDem >= 1),
    TienPhong   DECIMAL(18,0) NOT NULL DEFAULT 0,
    TienDichVu  DECIMAL(18,0) NOT NULL DEFAULT 0,
    TienCoc     DECIMAL(18,0) NOT NULL DEFAULT 0,
    TongTien    DECIMAL(18,0) NOT NULL DEFAULT 0,
    NguoiLap    VARCHAR(50)   NULL,
    CONSTRAINT FK_HOADON_PHIEUNHAN FOREIGN KEY (MaPhieuNhan) REFERENCES PHIEUNHAN(MaPhieuNhan),
    CONSTRAINT FK_HOADON_NGUOIDUNG FOREIGN KEY (NguoiLap)    REFERENCES NGUOIDUNG(TenDangNhap)
);
GO

/* =====================================================================
   DU LIEU MAU
   ===================================================================== */

-- Tai khoan: mat khau mac dinh la 123456 (ma hoa SHA-256, chu HOA)
INSERT INTO NGUOIDUNG (TenDangNhap, MatKhau, HoTen, Quyen) VALUES
('admin', CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', '123456'), 2), N'Quản trị viên', 'Admin'),
('nv01',  CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', '123456'), 2), N'Nguyễn Thu Hà', 'NhanVien');

INSERT INTO LOAI_PHONG (MaLoaiPhong, TenLoaiPhong, DonGia, SoNguoiToiDa, MoTa) VALUES
('LP01', N'Phòng đơn',  300000, 1, N'1 giường đơn, phù hợp khách đi một mình'),
('LP02', N'Phòng đôi',  450000, 2, N'1 giường đôi, có điều hòa'),
('LP03', N'Phòng gia đình', 700000, 4, N'2 giường đôi, phù hợp gia đình');

INSERT INTO PHONG (MaPhong, TenPhong, MaLoaiPhong, Tang, TinhTrang) VALUES
('P101', N'Phòng 101', 'LP01', 1, 'Trong'),
('P102', N'Phòng 102', 'LP01', 1, 'Trong'),
('P103', N'Phòng 103', 'LP02', 1, 'Trong'),
('P201', N'Phòng 201', 'LP02', 2, 'Trong'),
('P202', N'Phòng 202', 'LP02', 2, 'Trong'),
('P203', N'Phòng 203', 'LP03', 2, 'Trong'),
('P301', N'Phòng 301', 'LP03', 3, 'Trong'),
('P302', N'Phòng 302', 'LP02', 3, 'DangDon');

INSERT INTO DICHVU (MaDV, TenDV, DonGia, DonViTinh) VALUES
('DV01', N'Nước suối',        10000,  N'Chai'),
('DV02', N'Bia',              25000,  N'Lon'),
('DV03', N'Giặt ủi',          30000,  N'Kg'),
('DV04', N'Ăn sáng',          50000,  N'Suất'),
('DV05', N'Thuê xe máy',      120000, N'Ngày'),
('DV06', N'Đưa đón sân bay',  250000, N'Chuyến');

INSERT INTO KHACHHANG (HoTen, CCCD, GioiTinh, NgaySinh, SDT, DiaChi) VALUES
(N'Trần Văn An',    '001090012345', N'Nam', '1990-05-12', '0901234567', N'Hà Nội'),
(N'Lê Thị Bích',    '001095067890', N'Nữ',  '1995-08-20', '0912345678', N'Hải Phòng'),
(N'Phạm Quốc Cường','001088034567', N'Nam', '1988-01-03', '0987654321', N'Đà Nẵng'),
(N'Nguyễn Thanh Dung','001092078901', N'Nữ', '1992-11-25', '0934567890', N'TP. Hồ Chí Minh');
GO

/* =====================================================================
   KIEM TRA NHANH (chay xong se thay so dong moi bang)
   ===================================================================== */
SELECT 'NGUOIDUNG'  AS Bang, COUNT(*) AS SoDong FROM NGUOIDUNG  UNION ALL
SELECT 'LOAI_PHONG',  COUNT(*) FROM LOAI_PHONG  UNION ALL
SELECT 'PHONG',       COUNT(*) FROM PHONG       UNION ALL
SELECT 'DICHVU',      COUNT(*) FROM DICHVU      UNION ALL
SELECT 'KHACHHANG',   COUNT(*) FROM KHACHHANG   UNION ALL
SELECT 'PHIEUDAT',    COUNT(*) FROM PHIEUDAT    UNION ALL
SELECT 'PHIEUNHAN',   COUNT(*) FROM PHIEUNHAN   UNION ALL
SELECT 'SUDUNGDICHVU',COUNT(*) FROM SUDUNGDICHVU UNION ALL
SELECT 'HOADON',      COUNT(*) FROM HOADON;
GO
----------------------------------------------------------------------
