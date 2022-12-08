-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 01, 2021 lúc 08:15 AM
-- Phiên bản máy phục vụ: 10.4.19-MariaDB
-- Phiên bản PHP: 8.0.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `englishdb`
--
CREATE DATABASE IF NOT EXISTS `englishdb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `englishdb`;

DELIMITER $$
--
-- Thủ tục
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `DanhsachHV_thuocLH_phutrach` (IN `maLH` VARCHAR(255), IN `maNV` VARCHAR(255))  begin
if manv in (select giangday.giaovienNhanvien from giangday) then -- nhan vien la giao vien
  begin
    if malh in (select giangday.lophocmalh from giangday where giangday.giaovienNhanvien = manv) then -- xuat bang hoc vien
      select hocvien.mahv, hocvien.ho, hocvien.tendem, hocvien.ten, (year(CURRENT_TIME()) - hocvien.Namsinh) as Tuoi
        from hocvien join dangky on hocvien.MaHV = dangky.hocvienMaHV
        			join giangday on dangky.lophocMaLH = giangday.lophocMaLH 
                    where giangday.giaovienNhanvien = manv and dangky.lophocMaLH = malh;
    else select 'Lớp học này không do bạn phụ trách' as 'Result';
    end if;
  end;
  elseif manv in (select hotro.trogiangNhanvien from hotro) then -- nhan vien la tro giang
  begin
    if malh in (select hotro.lophocmalh from hotro where hotro.trogiangNhanvien = manv) then -- xuat bang hoc vien
      select hocvien.mahv, hocvien.ho, hocvien.tendem, hocvien.ten, (year(CURRENT_TIME()) - hocvien.Namsinh) as Tuoi
        from hocvien join dangky on hocvien.MaHV = dangky.hocvienMaHV
        			join hotro on dangky.lophocMaLH = hotro.lophocMaLH 
                    where hotro.trogiangNhanvien = manv and dangky.lophocMaLH = malh;
    else select 'Lớp học này không do bạn phụ trách' as 'Result';
    end if;    
  end;
  else select 'Không tồn tại giáo viên hoặc trợ giảng sỡ hữu mã nhân viên này.' as 'Result';
  end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DanhsachKhoaHoc` ()  begin
  select *
    from khoahoc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DanhsachLH_phutrach_Thongtinchitiet_GV` (IN `maNV` VARCHAR(255), IN `trangthai` ENUM('hientai','toanbo'))  begin
  if (manv in (select manv from giangday)) then  -- neu nhan vien la giao vien
    if (trangthai = 'toanbo') then -- xem toan bo nhung lop ma minh phu trach
      begin
        -- xem giao vien va tro giang phu trach cung lop voi minh
        select * from giangday where giangday.lophocMaLH in (
          select malh from lophoc where lophoc.malh in (
            select giangday.lophocmalh from giangday where giangday.giaovienNhanvien = manv));
      end;
    else 
      begin
        -- xem giao vien va tro giang phu trach cung lop voi minh
        select * from giangday where giangday.lophocMaLH in (
          select malh from lophoc 
            where lophoc.malh in (select giangday.lophocmalh from giangday where giangday.giaovienNhanvien = manv)
            and lophoc.ngayketthuc > CURRENT_TIME());
      end;
    end if;

  elseif (manv in (select manv from hotro)) THEN -- neu nhan vien  la tro giang
    if (trangthai = 'toanbo') then -- xem toan bo nhung lop ma minh phu trach
      begin
        -- xem giao vien va tro giang phu trach cung lop voi minh
        select * from giangday where giangday.lophocMaLH in (
          select malh from lophoc where lophoc.malh in (
            select hotro.lophocmalh from giangday where hotro.trogiangNhanvien = manv));
      end;
    else 
      begin
        -- xem giao vien va tro giang phu trach cung lop voi minh
        select * from giangday 
          where giangday.lophocMaLH in (select malh from lophoc 
            where lophoc.malh in (select hotro.lophocmalh from giangday where hotro.trogiangNhanvien = manv)
            and lophoc.ngayketthuc > CURRENT_TIME());
      end;
    end if;
  else select 'Khong ton tai giao vien hoac tro giang co ma nhan vien nay' as ' ';
  end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DanhsachLH_phutrach_Thongtinchitiet_LH` (IN `maNV` VARCHAR(255), IN `trangthai` ENUM('hientai','toanbo'))  begin
  if (manv in (select manv from giangday)) then  -- neu nhan vien la giao vien
    if (trangthai = 'toanbo') then -- xem toan bo nhung lop ma minh phu trach
      begin
        select * from lophoc where lophoc.malh in (select giangday.lophocmalh from giangday where giangday.giaovienNhanvien = manv);
      end;
    else 
      begin -- xem nhung lop dang mo ma minh phu trach
        select * from lophoc 
          where lophoc.malh in (select giangday.lophocmalh from giangday where giangday.giaovienNhanvien = manv)
          and lophoc.ngayketthuc > CURRENT_TIME();
      end;
    end if;

  elseif (manv in (select manv from hotro)) THEN -- neu nhan vien  la tro giang
    if (trangthai = 'toanbo') then -- xem toan bo nhung lop ma minh phu trach
      begin
        select * from lophoc where lophoc.malh in (select hotro.lophocmalh from giangday where hotro.trogiangNhanvien = manv);
      end;
    else 
      begin -- xem nhung lop dang mo ma minh phu trach
        select * from lophoc 
          where lophoc.malh in (select hotro.lophocmalh from giangday where hotro.trogiangNhanvien = manv)
          and lophoc.ngayketthuc > CURRENT_TIME();
      end;
    end if;
  else select 'Khong ton tai giao vien hoac tro giang co ma nhan vien nay' as ' ';
  end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DanhsachLH_phutrach_Thongtinchitiet_TG` (IN `maNV` VARCHAR(255), IN `trangthai` ENUM('hientai','toanbo'))  begin
  if (manv in (select manv from giangday)) then  -- neu nhan vien la giao vien
    if (trangthai = 'toanbo') then -- xem toan bo nhung lop ma minh phu trach
      begin
        select * from hotro where hotro.lophocmalh in (
          select malh from lophoc where lophoc.malh in (
            select giangday.lophocmalh from giangday where giangday.giaovienNhanvien = manv));
      end;
    else 
      begin
        select * from hotro where hotro.lophocmalh in (
          select malh from lophoc 
            where lophoc.malh in (select giangday.lophocmalh from giangday where giangday.giaovienNhanvien = manv)
            and lophoc.ngayketthuc > CURRENT_TIME());
      end;
    end if;

  elseif (manv in (select manv from hotro)) THEN -- neu nhan vien  la tro giang
    if (trangthai = 'toanbo') then -- xem toan bo nhung lop ma minh phu trach
      begin
        select * from hotro where hotro.lophocmalh in (
          select malh from lophoc where lophoc.malh in (
            select hotro.lophocmalh from giangday where hotro.trogiangNhanvien = manv));
      end;
    else 
      begin
        select * from hotro 
          where hotro.lophocmalh in (select malh from lophoc 
            where lophoc.malh in (select hotro.lophocmalh from giangday where hotro.trogiangNhanvien = manv)
            and lophoc.ngayketthuc > CURRENT_TIME());
      end;
    end if;
  else select 'Khong ton tai giao vien hoac tro giang co ma nhan vien nay' as ' ';
  end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DanhsachLH_phutrach_Thongtinchitiet_TKB` (IN `maNV` VARCHAR(255), IN `trangthai` ENUM('hientai','toanbo'))  begin
  if (manv in (select manv from giangday)) then  -- neu nhan vien la giao vien
    if (trangthai = 'toanbo') then -- xem toan bo nhung lop ma minh phu trach
      begin
        select * from thoikhoabieu_lh where thoikhoabieu_lh.lophocMaLH in (
          select malh from lophoc where lophoc.malh in (
            select giangday.lophocmalh from giangday where giangday.giaovienNhanvien = manv));
      end;
    else 
      begin
        select * from thoikhoabieu_lh where thoikhoabieu_lh.lophocMaLH in (
          select malh from lophoc 
            where lophoc.malh in (select giangday.lophocmalh from giangday where giangday.giaovienNhanvien = manv)
            and lophoc.ngayketthuc > CURRENT_TIME());
      end;
    end if;

  elseif (manv in (select manv from hotro)) THEN -- neu nhan vien  la tro giang
    if (trangthai = 'toanbo') then -- xem toan bo nhung lop ma minh phu trach
      begin
        -- xem thoikhoabieu cuar lop minh phu trach
        select * from thoikhoabieu_lh where thoikhoabieu_lh.lophocMaLH in (
          select malh from lophoc where lophoc.malh in (
            select hotro.lophocmalh from giangday where hotro.trogiangNhanvien = manv));
      end;
    else 
      begin
        select * from thoikhoabieu_lh 
          where thoikhoabieu_lh.lophocMaLH in (select malh from lophoc 
            where lophoc.malh in (select hotro.lophocmalh from giangday where hotro.trogiangNhanvien = manv)
            and lophoc.ngayketthuc > CURRENT_TIME());
      end;
    end if;
  else select 'Khong ton tai giao vien hoac tro giang co ma nhan vien nay' as ' ';
  end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DanhsachToanboGiaotrinh` ()  begin
    select * from giaotrinh;   
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lophoc_delete` (IN `maLH` VARCHAR(255))  BEGIN	
    DELETE FROM lophoc WHERE lophoc.MaLH = maLH;   
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lophoc_insert` (IN `maLH` VARCHAR(255), IN `ngaybatdau` DATETIME, IN `ngayketthuc` DATETIME, IN `maCN` VARCHAR(255), IN `maKH` VARCHAR(255))  BEGIN
	IF (ngaybatdau IS NOT null AND ngayketthuc IS NOT null 
        AND (datediff(ngayketthuc, ngaybatdau)/7) < (SELECT khoahoc.Thoiluong FROM khoahoc WHERE khoahoc.MaKH = maKH))
		THEN 
        select 'Thời lượng lớp học quá ngắn so với thời lượng khóa học chứa nó.' as 'Result';
        
    else insert into lophoc values(maLH, ngaybatdau, ngayketthuc, 0, maCN, maKH);
	end if;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lophoc_update` (IN `maLH` VARCHAR(255), IN `ngaybatdau` DATETIME, IN `ngayketthuc` DATETIME, IN `maCN` VARCHAR(255), IN `maKH` VARCHAR(255))  BEGIN	
	IF (ngaybatdau IS NOT null AND ngayketthuc IS NOT null 
        AND (datediff(ngayketthuc, ngaybatdau)/7) < (SELECT khoahoc.Thoiluong FROM khoahoc WHERE khoahoc.MaKH = maKH))
		THEN begin
        select 'Thời lượng lớp học quá ngắn so với thời lượng khóa học chứa nó.' as 'Result';
        end;
    else UPDATE lophoc
        SET lophoc.Ngaybatdau = ngaybatdau,
            lophoc.Ngayketthuc = ngayketthuc,
            lophoc.chinhanhMaCN = maCN,
            lophoc.khoahocMaKH = maKH
    WHERE lophoc.MaLH = maLH;
    select 'Success' as 'Result';
	end if;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sudung_delete` (IN `maGT` VARCHAR(255), IN `maKH` VARCHAR(255))  begin
    if ((select count(*) from `sudung` where khoahocMaKH = MaKH) = 1) then 
		select 'Khoá học phải sử dụng ít nhất 1 giáo trình.' as 'Result';
    else delete from `sudung` where khoahocMaKH = makh and giaotrinhmagt = magt;
    select 'Ok' as 'Result';
    end if;
   
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sudung_insert` (IN `maGT` VARCHAR(255), IN `maKH` VARCHAR(255))  begin
    if ((select count(*) from `sudung` where khoahocMaKH = MaKH) = 3) then 
		select 'Khoá học này đã sử dụng 3 giáo trình.' as 'Result';
    else insert into `sudung` values (maGT, maKH);
    end if;
        
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ThongTinChiTietKH_hientai` (IN `maKH` VARCHAR(255))  begin
  if exists (select maKH from khoahoc where khoahoc.makh = makh)
    then begin
      call DanhSachGVthuocKH_hientai(makh);
      call DanhSachTGthuocKH_hientai(makh);
      call DanhSachGTrinhthuocKH(makh);
    end;
  else signal sqlstate '45000' set message_text = 'Không tồn tại khóa học này';
  end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ThongTinChiTietKH_toanbo` (IN `maKH` VARCHAR(255))  begin
  if exists (select maKH from khoahoc where khoahoc.makh = makh)
    then begin
      call DanhSachGVthuocKH_toanbo(makh);
      call DanhSachTGthuocKH_toanbo(makh);
      call DanhSachGTrinhthuocKH(makh);
    end;
  else signal sqlstate '45000' set message_text = 'Không tồn tại khóa học này';
  end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `xemdanhsachLH_dangmo` (IN `makh` VARCHAR(255))  begin

	select * from lophoc
    where lophoc.ngayketthuc > CURDATE()  and lophoc.khoahocmakh = makh;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `xemdanhsachTKB_LH_dangmo` (IN `makh` VARCHAR(255))  begin
    
    select * from thoikhoabieu_lh where thoikhoabieu_lh.lophocmalh in (
		select malh from lophoc
    where datediff(lophoc.ngayketthuc, curdate()) > 0  and lophoc.khoahocmakh = makh);
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `xemdanhsach_dangky_hientai_HV` (IN `mahv` VARCHAR(255))  select lophoc.malh, lophoc.ngaybatdau, lophoc.ngayketthuc, lophoc.siso, lophoc.chinhanhmacn, lophoc.khoahocmakh, khoahoc.ten,mahv
    from lophoc join khoahoc on lophoc.khoahocmakh = khoahoc.makh
    where lophoc.ngayketthuc > current_date()
    and lophoc.malh in (select lophocmalh from dangky where hocvienmahv = mahv)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `xemdanhsach_GT` (IN `maKH` VARCHAR(255))  BEGIN
	SELECT giaotrinh.MaGT, giaotrinh.Ten, giaotrinh.Namxuatban
	FROM giaotrinh JOIN sudung ON sudung.giaotrinhMaGT = giaotrinh.MaGT
	WHERE sudung.khoahocMaKH = maKH;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `xemdanhsach_GV` (IN `maKH` VARCHAR(255))  begin
	SELECT lophoc.MaLH, giangday.giaovienNhanvien AS MaGiaoVien, nhanvien.Ho AS HoGV, nhanvien.Tendem AS TendemGV, nhanvien.Ten AS TenGV
    FROM lophoc 
            JOIN giangday ON lophoc.MaLH = giangday.lophocMaLH 
            JOIN hotro ON hotro.lophocMaLH = lophoc.MaLH 
            JOIN nhanvien ON nhanvien.MaNV = giangday.giaovienNhanvien
    WHERE lophoc.khoahocMaKH = maKH;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `xemdanhsach_TG` (IN `maKH` VARCHAR(255))  begin

	SELECT lophoc.MaLH, hotro.trogiangNhanvien AS MaTroGiang, nhanvien.Ho AS HoTG, nhanvien.Tendem AS TendemTG, nhanvien.Ten AS TenTG
    FROM lophoc 
            JOIN giangday ON lophoc.MaLH = giangday.lophocMaLH 
            JOIN hotro ON hotro.lophocMaLH = lophoc.MaLH 
            JOIN nhanvien ON nhanvien.MaNV = hotro.trogiangNhanvien
    WHERE lophoc.khoahocMaKH = maKH;


END$$

--
-- Các hàm
--
CREATE DEFINER=`root`@`localhost` FUNCTION `Check_GV_TG` (`MaNV` VARCHAR(255)) RETURNS VARCHAR(255) CHARSET utf8mb4 BEGIN

    if (manv in (select manv from giangday)) then  -- neu nhan vien la giao vien
        return 'giaovien';
  elseif (manv in (select manv from hotro)) THEN -- neu nhan vien  la tro giang
        return 'trogiang';
  else  return 'khong';
  end if;         

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `chuyenlophoc` (`MaHV` VARCHAR(255), `MaLHchuyenden` VARCHAR(255), `MaLHhientai` VARCHAR(255)) RETURNS VARCHAR(255) CHARSET utf8mb4 BEGIN
	DECLARE a VARCHAR(255);
    DECLARE b VARCHAR(255);
    DECLARE MaKHhientai VARCHAR(255);
    DECLARE MaKHchuyenden VARCHAR(255);
    SELECT khoahocMaKH INTO MaKHhientai FROM lophoc WHERE lophoc.MaLH = MaLHhientai LIMIT 1;
    SELECT khoahocMaKH INTO MaKHchuyenden FROM lophoc WHERE lophoc.MaLH = MaLHchuyenden LIMIT 1;
    
    IF (MaKHhientai = MaKHchuyenden) THEN 
    
        DELETE FROM `dangky` WHERE dangky.lophocMaLH = MaLHhientai AND dangky.hocvienMaHV = MaHV;
        SET a = dangkylophoc(MaHV,MaLHchuyenden);
        IF(a != 'Succesfully!') THEN
            INSERT INTO `dangky`(`Ngaydangky`, `lophocMaLH`, `hocvienMaHV`) VALUES (CURDATE(),MaLHhientai,MaHV);
        ELSE
        	UPDATE lophoc SET lophoc.Siso = lophoc.Siso -1 WHERE lophoc.MaLH = MaLHhientai;
        END IF;
    ELSE 
    	SET a = 'Error!';
    END IF;
    RETURN a;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `dangkylophoc` (`MaHV` VARCHAR(255), `MaLH` VARCHAR(255)) RETURNS VARCHAR(255) CHARSET utf8mb4 BEGIN
    DECLARE result VARCHAR(255);
    DECLARE bd int(11);
    DECLARE MaKHfromin VARCHAR(255);
    DECLARE trinhdokh int(11);
	DECLARE trinhdohv int(11);
    DECLARE ac int(11);
    DECLARE getdate datetime;
    DECLARE getdatekhtrung datetime;
   

	SELECT khoahocMaKH INTO MaKHfromin FROM lophoc WHERE lophoc.MaLH = MaLH LIMIT 1;
	SELECT Gioihansiso INTO bd FROM khoahoc WHERE  khoahoc.MaKH = MaKHfromin LIMIT 1;
	SELECT Yeucautrinhdo INTO trinhdokh FROM khoahoc WHERE  khoahoc.MaKH = MaKHfromin LIMIT 1;
    SELECT Diem INTO trinhdohv FROM trinhdo_hv WHERE Ngaycapnhat
              IN (SELECT MAX(getmax) FROM (SELECT Ngaycapnhat AS getmax FROM trinhdo_hv WHERE  trinhdo_hv.hocvienMaHV = MaHV) AS T)
              AND hocvienMaHV = MaHV LIMIT 1;
	SELECT Siso,Ngaybatdau INTO ac,getdate FROM lophoc WHERE  lophoc.MaLH = MaLH LIMIT 1;
               
               
    IF(SELECT EXISTS (SELECT khoahocMaKH FROM lophoc WHERE lophoc.MaLH IN( SELECT lophocMaLH FROM dangky WHERE dangky.hocvienMaHV = MaHV) 
        AND  lophoc.khoahocMaKH  =  MaKHfromin ))  THEN
    	SELECT Ngayketthuc INTO getdatekhtrung FROM lophoc WHERE lophoc.MaLH IN( SELECT lophocMaLH FROM dangky WHERE hocvienMaHV = MaHV) AND lophoc.khoahocMaKH = MaKHfromin LIMIT 1;
    ELSE
    	SET getdatekhtrung = '1900-01-01 00:00:00';
    END IF;
    	    
    IF (SELECT EXISTS (SELECT `Ngay`, `Giobatdau`, `Gioketthuc` FROM (
        SELECT `Ngay`, `Giobatdau`, `Gioketthuc` FROM `thoikhoabieu_lh` WHERE lophocMaLH 
    	IN (SELECT lophocMaLH FROM dangky WHERE hocvienMaHV = MaHV)
        AND lophocMaLH IN (SELECT MaLH FROM `lophoc` WHERE Ngayketthuc > CURDATE())
   						
        UNION ALL
        SELECT `Ngay`, `Giobatdau`, `Gioketthuc` FROM `thoikhoabieu_lh` WHERE lophocMaLH = MaLH) AS T 
        GROUP BY `Ngay`, `Giobatdau`, `Gioketthuc`
        HAVING COUNT(*) = 2) = 0 ) THEN
        IF 	(trinhdohv >= trinhdokh) THEN
            IF (getdate > CURDATE() - INTERVAL 2 WEEK) THEN 
                IF (bd > ac) THEN
                    IF(getdatekhtrung < getdate) THEN
                        INSERT INTO `dangky`(`Ngaydangky`, `lophocMaLH`, `hocvienMaHV`) VALUES (CURDATE(),MaLH,MaHV);
                        UPDATE `lophoc` SET`Siso`=ac+1 WHERE lophoc.MaLH = MaLH;
                        SET result = 'Succesfully!';
                    ELSE
                       SET result = '1';	 -- Error! Ban chua ket thuc khoa hoc nay
                    END IF;
                ELSE 
                    SET result = '2'; -- Error! Lop da day
                END IF;
             ELSE
                 SET result = '3'; -- Error! Lop da bat dau 2 tuan
             END IF;
        ELSE
        	SET result = '4'; -- Error! Ban khong du trinh do
        END IF;
    ELSE
    	SET result = '5'; -- Error! Trung thoi khoa bieu
    END IF;
    RETURN result;
         

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `huydangkylophoc` (`MaHV` VARCHAR(255), `MaLH` VARCHAR(255)) RETURNS VARCHAR(255) CHARSET utf8mb4 BEGIN
    DECLARE result VARCHAR(255);
    DECLARE getdate datetime;
    DECLARE ac int(11);

	SELECT Siso INTO ac FROM lophoc WHERE  lophoc.MaLH = MaLH LIMIT 1;
	SELECT Ngaydangky INTO getdate FROM dangky WHERE lophocMaLH = MaLH AND hocvienMaHV = MaHV LIMIT 1;
	
    IF (getdate > CURDATE() - INTERVAL 1 WEEK) THEN 
    	DELETE FROM `dangky` WHERE lophocMaLH = MaLH AND hocvienMaHV = MaHV;
        UPDATE `lophoc` SET`Siso`=ac-1 WHERE lophoc.MaLH = MaLH;
        SET result = 'Succesfully!';
    ELSE 
    	SET result = 'Error!';
    END IF;
    RETURN result;
         

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chinhanh`
--

CREATE TABLE `chinhanh` (
  `MaCN` varchar(255) NOT NULL,
  `Ten` varchar(255) DEFAULT NULL,
  `Sonha` varchar(255) DEFAULT NULL,
  `Duong` varchar(255) DEFAULT NULL,
  `Quanhuyen` varchar(255) DEFAULT NULL,
  `Tinhtp` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `chinhanh`
--

INSERT INTO `chinhanh` (`MaCN`, `Ten`, `Sonha`, `Duong`, `Quanhuyen`, `Tinhtp`) VALUES
('BD001', 'T2E CMT8', '78', 'Cách Mạng Tháng 8', 'Thành phố Thủ Dầu 1', 'Bình Dương'),
('BD002', 'T2E Dĩ An', '22', 'đường M', 'thành phố Dĩ An', 'Bình Dương'),
('DN001', 'T2E Nguyễn Văn Linh', '99A', 'Nguyễn Văn Linh', 'Quận Hải Châu', 'Đà Nẵng'),
('HCM001', 'T2E Nguyễn Thị Minh Khai', '189', 'Nguyễn Thị Minh Khai', 'Quận 1', 'HCM'),
('HCM002', 'T2E Võ Thị Sáu', '78', 'Võ Thị Sáu', 'Quận 1', 'HCM'),
('HCM003', 'T2E Trần Não', '58B', 'Trần Não', 'Quận 2', 'HCM'),
('HCM004', 'T2E Khánh Hội', '245', 'Khánh Hội', 'Quận 4', 'HCM'),
('HCM005', 'T2E An Dương Vương', '135', 'An Dương Vương', 'Quận 5', 'HCM'),
('HCM006', 'T2E Bà Hom', '63', 'Bà Hom', 'Quận 6', 'HCM'),
('HCM007', 'T2E Nguyễn Khắc Viện', '25', 'Nguyễn Khắc Viện', 'Quận 7', 'HCM'),
('HCM008', 'T2E Xa Lộ Hà Nội', '76A', 'Xa Lộ Hà Nội', 'Quận 9', 'HCM'),
('HCM009', 'T2E Nguyễn Chí Thanh', '282', 'Nguyễn Chí Thanh', 'Quận 10', 'HCM'),
('HCM010', 'T2E Trường Chinh', '187', 'Trường Chinh', 'Quận 12', 'HCM'),
('HCM011', 'T2E Tô Ký', '55', 'Tô Ký', 'Quận 12', 'HCM'),
('HCM012', 'T2E Cộng Hòa', '105', 'Cộng Hòa', 'Quận Tân Bình', 'HCM'),
('HCM013', 'T2E Quang Trung ', '651', 'Quang Trung', 'Quận Gò Vấp', 'HCM'),
('HCM014', 'T2E Tô Ngọc Vân', '485', 'Tô Ngọc Vân', 'Quận Thủ Đức', 'HCM'),
('HCM015', 'T2E Tô Ký 2', '30/13', 'Tô Ký', 'Huyện Hóc Môn', 'HCM'),
('HN001', 'T2E Lê Văn Lương', '145', 'Lê Văn Lương', 'Quận Thanh Xuân', 'Hà Nội'),
('HN002', 'T2E Cầu Giấy', '299', 'Cầu Giấy', 'Quận Cầu Giấy', 'Hà Nội'),
('HN003', 'T2E Nguyễn Lương Bằng', '187', 'Nguyễn Lương Bằng', 'Quận Đống Đa', 'Hà Nội'),
('HN004', 'T2E TimeCity', '458', 'Minh Khai', 'Quận Hai Bà Trưng', 'Hà Nội');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `congtac_gv`
--

CREATE TABLE `congtac_gv` (
  `giaovienNhanvien` varchar(255) NOT NULL,
  `chinhanhMaCN` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `congtac_gv`
--

INSERT INTO `congtac_gv` (`giaovienNhanvien`, `chinhanhMaCN`) VALUES
('GV001', 'HCM009'),
('GV002', 'HCM010'),
('GV003', 'HCM009'),
('GV004', 'HCM014'),
('GV005', 'HN001');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `congtac_tg`
--

CREATE TABLE `congtac_tg` (
  `trogiangNhanvien` varchar(255) NOT NULL,
  `chinhanhMaCN` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `congtac_tg`
--

INSERT INTO `congtac_tg` (`trogiangNhanvien`, `chinhanhMaCN`) VALUES
('TG001', 'HCM009'),
('TG002', 'HCM010'),
('TG003', 'HCM014'),
('TG004', 'HN001');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dangky`
--

CREATE TABLE `dangky` (
  `Ngaydangky` datetime NOT NULL,
  `lophocMaLH` varchar(255) NOT NULL,
  `hocvienMaHV` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `dangky`
--

INSERT INTO `dangky` (`Ngaydangky`, `lophocMaLH`, `hocvienMaHV`) VALUES
('2021-12-01 00:00:00', 'KN001_L02', '1593031'),
('2021-09-20 00:00:00', 'KN003_L03', '1711314'),
('2021-09-27 00:00:00', 'KN003_L03', '1712005'),
('2021-09-26 00:00:00', 'KN003_L03', '1820566'),
('2021-09-30 00:00:00', 'KN003_L03', '1912190'),
('2021-09-28 00:00:00', 'OT001_L01', '1254741'),
('2021-09-24 00:00:00', 'OT001_L01', '1312451'),
('2021-09-23 00:00:00', 'OT001_L01', '1611000'),
('2021-09-24 00:00:00', 'OT001_L01', '1611204'),
('2021-09-28 00:00:00', 'OT001_L01', '1845621'),
('2021-09-28 00:00:00', 'OT001_L01', '1912123'),
('2021-09-22 00:00:00', 'OT001_L01', '1912322'),
('2021-09-26 00:00:00', 'OT001_L02', '1021000'),
('2021-09-25 00:00:00', 'OT001_L02', '1311004'),
('2021-09-26 00:00:00', 'OT001_L02', '1514001'),
('2021-09-22 00:00:00', 'OT001_L02', '1514002'),
('2021-09-25 00:00:00', 'OT001_L02', '1623445'),
('2021-09-24 00:00:00', 'OT001_L02', '1810333'),
('2021-09-25 00:00:00', 'OT001_L02', '1911704'),
('2021-09-27 00:00:00', 'OT001_L02', '1915888'),
('2021-09-29 00:00:00', 'OT001_L02', '2012222'),
('2021-12-01 00:00:00', 'OT003_L01', '1593031'),
('2021-09-21 00:00:00', 'TNH001_L01', '1412667'),
('2021-09-26 00:00:00', 'TNH001_L01', '1623558'),
('2021-09-21 00:00:00', 'TNH001_L01', '1710512'),
('2021-09-21 00:00:00', 'TNH001_L01', '1811314'),
('2021-09-29 00:00:00', 'TNH001_L01', '1910448'),
('2021-09-20 00:00:00', 'TNH001_L01', '1911314'),
('2021-09-22 00:00:00', 'TNH001_L01', '1911837'),
('2021-09-20 00:00:00', 'TNH001_L01', '1911900'),
('2021-09-26 00:00:00', 'TNH001_L01', '2011314'),
('2021-09-29 00:00:00', 'TNH001_L01', '2013666');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `danhgia_kh`
--

CREATE TABLE `danhgia_kh` (
  `Ten` varchar(255) NOT NULL,
  `Noidung` varchar(255) NOT NULL,
  `khoahocMaKH` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `danhgia_kh`
--

INSERT INTO `danhgia_kh` (`Ten`, `Noidung`, `khoahocMaKH`) VALUES
('Hoàng Văn Phi', 'Khóa học này giúp cho con tôi có điểm số tốt hơn trên trường và tự tin hơn trong cuộc sống.', 'TN001'),
('Lê Thanh Trúc', 'Ôn thi ở đây rất vui vì các thầy cô tạo được tinh thần thoải mái, kiên nhẫn giảng dạy những điểm tôi không hiểu. Tôi đã đạt kết quả cao hơn mong đợi.', 'OT001'),
('Lê Trần Hoàng Thịnh', 'Sau khi học khóa học này, em thấy kỹ năng thuyết trình và nói trước đám đông khi dùng ngoại ngữ của mình được cải thiện nhiều. Các bạn hòa đồng và thầy cô cũng thân thiện.', 'KN003'),
('Lê Văn Đông', 'Khóa học giúp tôi tự tin hơn trong giao tiếp hằng ngày, giúp tôi tiếp xúc với người nước ngoài không còn bị ấp úng.', 'KN001'),
('Ngô Anh Đức', 'Các thầy cô chỉ dạy rất kỹ, chương trình sát với đề thi thật nên ôn tập đạt hiệu quả cao.', 'OT006'),
('Ngô Hoàng Giang', 'Ôn thi ở đây rất hiệu quả, tôi đã đạt được mục tiêu mình đề ra trong thời gian ngắn, đã có đủ điều kiện anh văn để tốt nghiệp.', 'OT005'),
('Nguyễn Phi Hùng', 'Khóa học giúp em lấy lại căn bản môn tiếng anh, các thầy cô rất tận tình và giảng bài cũng dễ hiểu.', 'KN004'),
('Nguyễn Thanh Huyền', 'Con tôi rất thích học khóa này, các thầy cô tận tình và dạy dễ hiểu nên bé tiếp thu nhanh.', 'TNH002'),
('Đinh Gia Quang', 'Ban đầu em gặp khó khăn trong việc nghe nói tiếng anh, nhờ có khóa học này mà em đã tự tin hơn nhiều', 'KN004');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dieuchinh_kh`
--

CREATE TABLE `dieuchinh_kh` (
  `khoahocMaKH` varchar(255) NOT NULL,
  `quanlygiaoducNhanvien` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `dieuchinh_kh`
--

INSERT INTO `dieuchinh_kh` (`khoahocMaKH`, `quanlygiaoducNhanvien`) VALUES
('KN001', 'QL001'),
('KN002', 'QL001'),
('KN003', 'QL001'),
('KN004', 'QL001'),
('OT001', 'QL002'),
('OT002', 'QL002'),
('OT003', 'QL002'),
('OT004', 'QL002'),
('OT005', 'QL002'),
('OT006', 'QL002'),
('OT007', 'QL002'),
('TN001', 'QL003'),
('TNH001', 'QL003'),
('TNH002', 'QL003');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dieuchinh_lh`
--

CREATE TABLE `dieuchinh_lh` (
  `lophocMaLH` varchar(255) NOT NULL,
  `quanlygiaoducNhanvien` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `dieuchinh_lh`
--

INSERT INTO `dieuchinh_lh` (`lophocMaLH`, `quanlygiaoducNhanvien`) VALUES
('KN001_L02', 'QL001'),
('KN003_L03', 'QL001'),
('KN004_L01', 'QL001'),
('OT001_L01', 'QL002'),
('OT001_L02', 'QL002'),
('OT002_L01', 'QL002'),
('OT002_L02', 'QL002'),
('TNH001_L01', 'QL003'),
('TNH001_L02', 'QL003');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `doituong_kh`
--

CREATE TABLE `doituong_kh` (
  `Doituong` varchar(255) NOT NULL,
  `khoahocMaKH` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `doituong_kh`
--

INSERT INTO `doituong_kh` (`Doituong`, `khoahocMaKH`) VALUES
('Doanh nhân', 'KN002'),
('Học sinh muốn trau dồi anh văn', 'TN001'),
('Người có nhu cầu ôn thi IELTS', 'OT001'),
('Người có nhu cầu ôn thi IELTS', 'OT002'),
('Người có nhu cầu ôn thi IELTS', 'OT003'),
('Người có nhu cầu ôn thi IELTS', 'OT004'),
('Người có nhu cầu ôn thi TOEIC', 'OT005'),
('Người có nhu cầu ôn thi TOEIC', 'OT006'),
('Người có nhu cầu ôn thi TOEIC', 'OT007'),
('Người mất căn bản tiếng anh', 'KN004'),
('Người muốn trau dồi tiếng anh', 'KN001'),
('Người thụ động', 'KN003'),
('Người yếu nghe nói', 'KN003'),
('Nhân viên văn phòng', 'KN002'),
('Thiếu niên khoảng 11 - 15 tuổi', 'TN001'),
('Trẻ cần làm quen với tiếng anh', 'TNH001'),
('Trẻ mẫu giáo', 'TNH001'),
('Trẻ thích hoạt động ngoại khóa', 'TNH002'),
('Trẻ trong độ tuổi tiểu học', 'TNH002');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `giangday`
--

CREATE TABLE `giangday` (
  `lophocMaLH` varchar(255) NOT NULL,
  `giaovienNhanvien` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `giangday`
--

INSERT INTO `giangday` (`lophocMaLH`, `giaovienNhanvien`) VALUES
('KN001_L02', 'GV001'),
('KN003_L03', 'GV001'),
('KN004_L01', 'GV002'),
('OT001_L01', 'GV003'),
('OT001_L02', 'GV003'),
('OT002_L01', 'GV004'),
('OT002_L02', 'GV004'),
('TNH001_L01', 'GV005'),
('TNH001_L02', 'GV005');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `giaotrinh`
--

CREATE TABLE `giaotrinh` (
  `MaGT` varchar(255) NOT NULL,
  `Ten` varchar(255) NOT NULL,
  `Namxuatban` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `giaotrinh`
--

INSERT INTO `giaotrinh` (`MaGT`, `Ten`, `Namxuatban`) VALUES
('KN001_GT01', 'Tài liệu độc quyền', 2021),
('KN002_GT01', 'Tài liệu độc quyền', 2021),
('KN003_GT01', 'Tài liệu độc quyền', 2021),
('KN004_GT01', 'Tài liệu độc quyền', 2021),
('OT001_GT01', 'Grammar In Use', 2015),
('OT001_GT02', 'Cambridge Grammar for IELTS', 2018),
('OT002_GT01', 'Cambridge Grammar for IELTS', 2018),
('OT002_GT02', 'Basic Vocabulary in Use', 2019),
('OT002_GT03', 'Destination B1 – B2', 2016),
('OT003_GT01', 'Vocabulary in use Intermediate', 2020),
('OT003_GT02', 'The Cambridge Official Guide to IELTS', 2019),
('OT003_GT03', 'Cambridge Practice Test for IELTS', 2018),
('OT004_GT01', 'How to crack the IELTS Speaking Test', 2020),
('OT004_GT02', 'Cambridge Practice Test Plus', 2017),
('OT005_GT01', 'Developing Skills for the TOEIC Test', 2015),
('OT005_GT02', 'TOEIC PDF Economy TOEIC 1000', 2018),
('OT006_GT01', 'Big Step Toeic', 2019),
('OT006_GT02', 'Pronunciation in American English', 2019),
('OT007_GT01', 'TOEIC Analyst', 2016),
('OT007_GT02', 'Economy Toeic 1000 volume', 2019),
('TN001_GT01', 'Solution', 2019),
('TN001_GT02', 'Tài liệu độc quyền', 2021),
('TNH001_GT01', 'My Little Island', 2018),
('TNH001_GT02', 'Family and Friends', 2020),
('TNH002_GT01', 'Amazing Science', 2019),
('TNH002_GT02', 'Family and Friends', 2020);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `giaovien`
--

CREATE TABLE `giaovien` (
  `Kinhnghiem` varchar(255) NOT NULL,
  `nhanvienMaNV` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `giaovien`
--

INSERT INTO `giaovien` (`Kinhnghiem`, `nhanvienMaNV`) VALUES
('7', 'GV001'),
('8', 'GV002'),
('10', 'GV003'),
('6', 'GV004'),
('8', 'GV005');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `hocvien`
--

CREATE TABLE `hocvien` (
  `MaHV` varchar(255) NOT NULL,
  `Ho` varchar(255) DEFAULT NULL,
  `Tendem` varchar(255) DEFAULT NULL,
  `Ten` varchar(255) DEFAULT NULL,
  `Gioitinh` enum('male','female') DEFAULT NULL,
  `Email` varchar(255) NOT NULL,
  `Namsinh` int(11) DEFAULT NULL,
  `Sonha` varchar(255) DEFAULT NULL,
  `Duong` varchar(255) DEFAULT NULL,
  `Quanhuyen` varchar(255) DEFAULT NULL,
  `Tinhtp` varchar(255) DEFAULT NULL,
  `Sodienthoai` int(11) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `hocvien`
--

INSERT INTO `hocvien` (`MaHV`, `Ho`, `Tendem`, `Ten`, `Gioitinh`, `Email`, `Namsinh`, `Sonha`, `Duong`, `Quanhuyen`, `Tinhtp`, `Sodienthoai`, `password`) VALUES
('', 'Ngô ', 'Diễm ', 'Quỳnh', NULL, '', 2001, '123A', 'Nguyễn Tất Thành', 'Buôn Hồ', 'Đắk Lắk', 368691668, NULL),
('1021000', 'Lê', 'Văn', 'Nam', 'male', 'loc_le@gmail.com', 2000, '70', 'Trống Đồng', 'Quận 10', 'TPHCM', NULL, NULL),
('1021010', 'Hà', 'Văn', 'Nam', 'male', 'loc_le11@gmail.com', 2010, '70', 'Lý thường kiệt', 'Quận 10', 'TPHCM', NULL, NULL),
('1254741', 'Lê', 'Trần Hoàng', 'Khang', 'male', 'khang.le2k8@gmail.com', 2008, '34B', 'Lý Thường Kiệt', 'Quận 10', 'TPHCM', NULL, NULL),
('1311004', 'Trần', 'Hoàng', 'Dương', 'male', 'duongtran@gmail.com', 2011, '150', 'Âu Cơ', 'Quận 11', 'HCM', NULL, NULL),
('1312451', 'Hồ', 'Thanh', 'Hiền', 'female', 'hienthanh@gmail.com', 2010, '361', 'Lý Thường Kiệt', 'Quận 10', 'HCM', NULL, NULL),
('1412667', 'Đinh', 'Gia', 'Bảo', 'male', 'giabao2k7@gmail.com', 2007, '321', 'Tô Ngọc Vân', 'Quận Thủ Đức', 'HCM', NULL, NULL),
('1514001', 'Tiêu', 'Phi', 'Hoàng', 'male', 'hoang.tieu_phi@gmail.com', 2013, '20', 'Lạc Long Quân', 'Quận 11', 'HCM', NULL, NULL),
('1514002', 'Tiêu', 'Phi', 'Hùng', 'male', 'hung.tieu_phi@gmail.com', 2013, '20', 'Lạc Long Quân', 'Quận 11', 'HCM', NULL, NULL),
('1514226', 'Đỗ', 'Gia', 'Minh', 'male', 'minh.do0201@hcmut.edu.vn', 1996, '42/8B', 'ấp Mới 2 xã Trung Chánh', 'Huyện Hóc Môn', 'HCM', NULL, NULL),
('1593031', 'Hà ', 'Duy', ' Anh', 'male', 'duyanh@gmail.com', 2002, '12345678', 'Nguyễn Tất Thành', 'Buôn Hồ', 'Đắk Lắk', 1234567890, '$2b$15$CbO2oFyAZEP.HbGy5Jb/ke48LeXjLm5URWzBfOBk7IhOxGLJYe57C'),
('1611000', 'Vương', 'Phương', 'Linh', 'female', 'linh.vuong_1212@hcmut.edu.vn', 1998, '65', 'Trường Chinh', 'Quận 10', 'HCM', NULL, NULL),
('1611204', 'Đinh', 'Gia', 'Bảo', 'male', 'bao.dinh_1900@hcmut.edu.vn', 1995, '180', 'Lý Thường Kiệt', 'Quận 10', 'HCM', NULL, NULL),
('1611314', 'Hồ', 'Nguyễn Ngọc', 'Ánh', 'male', 'anh.nguyen_baby@hcmut.edu.vn', 1998, '111', 'Thanh Xuân', 'Quận Thanh Xuân', 'Hà Nội', NULL, NULL),
('1612224', 'Trần', 'Phương', 'Thảo', 'female', 'thaophuong@gmail.com', 1995, '149', 'Nguyễn Thái Học', 'Quận Ba Đình', 'Hà Nội', NULL, NULL),
('1623445', 'Vũ', 'Lê Hoàng', 'Tuấn', 'male', 'tuan.vu_le12@hcmut.edu.vn', 1998, '32', 'Âu Cơ', 'Quận 11', 'HCM', NULL, NULL),
('1623558', 'Lý', 'Thanh', 'Thanh', 'female', 'thanh.ly_thanh@hcmut.edu.vn', 1998, '52', 'Phạm Văn Đồng', 'Quận 9', 'HCM', NULL, NULL),
('1710512', 'Võ', 'Đình', 'Tùng', 'male', 'tung.vo_dinh@hcmut.edu.vn', 1999, '66', 'Tô Ngọc Vân', 'Quận Thủ Đức', 'HCM', NULL, NULL),
('1711314', 'Trần', 'Lê', 'Trinh', 'female', 'trinh.tran_1912@hcmut.edu.vn', 1998, '12/4A', 'ấp Mới 2 xã Trung Chánh', 'Huyện Hóc Môn', 'HCM', NULL, NULL),
('1712005', 'Trần', 'Thị', 'My', 'female', 'my.tran_mymy@hcmut.edu.vn', 1999, '12/10S', 'ấp Chánh 1 xã Tân Xuân', 'Huyện Hóc Môn', 'HCM', NULL, NULL),
('1810227', 'Ngô', 'Văn', 'Linh', 'male', 'linh.ngo203@hcmut.edu.vn', 2004, '32', 'Nguyễn Thái Học', 'Quận Ba Đình', 'Hà Nội', NULL, NULL),
('1810333', 'Hoàng', 'Văn Thanh', 'Hùng', 'male', 'hung.hoang@hcmut.edu.vn', 2002, '101', 'Âu Cơ', 'Quận 11', 'HCM', NULL, NULL),
('1811314', 'Ngô', 'Nguyễn Hoàng', 'Khanh', 'female', 'Khanh.ngonguyen@hcmut.edu.vn', 2002, '152', 'Phạm Văn Đồng', 'Quận Thủ Đức', 'HCM', NULL, NULL),
('1820566', 'Nguyễn', 'Lê Xuân', 'Yến', 'female', 'yen.lebaby@gmail.com', 2008, '25/6B', 'ấp Mới 2 xã Trung Chánh', 'Huyện Hóc Môn', 'HCM', NULL, NULL),
('1845621', 'Hồ', 'Đình', 'Trình', 'male', 'trinh.ho_22@hcmut.edu.vn', 1998, '152', 'Lý Thường Kiệt', 'Quận 10', 'HCM', NULL, NULL),
('1910448', 'Lê', 'Bình', 'An', 'male', 'an.le2k4@gmail.com', 2004, '20A', 'đường M', 'Quận Thủ Đức', 'HCM', NULL, NULL),
('1910666', 'Trần', 'Trung', 'Tuấn', 'male', 'tuan.traniubo@hcmut.edu.vn', 2001, '287', 'Ô Chợ Dừa', 'Quận Hai Bà Trưng', 'Hà Nội', NULL, NULL),
('1911314', 'Lê', 'Hoàng', 'Linh', 'male', 'linh.nguyen0201@hcmut.edu.vn', 2001, '50', 'Tô Ngọc Vân', 'Quận Thủ Đức', 'HCM', NULL, NULL),
('1911704', 'Nguyễn', 'Thủy', 'Ngọc', 'female', 'ngoc.nguyen1711@hcmut.edu.vn', 2001, '127', 'Lạc Long Quân', 'Quận 11', 'HCM', NULL, NULL),
('1911837', 'Chung', 'Đông', 'Phong', 'male', 'phong.chungdopo@hcmut.edu.vn', 2001, '187', 'Phạm Văn Đồng', 'Quận 9', 'HCM', NULL, NULL),
('1911900', 'Đinh', 'Gia', 'Quang', 'male', 'quang.dinhleaktb@hcmut.edu.vn', 2000, '52A', 'Phạm Văn Đồng', 'Quận Thủ Đức', 'HCM', NULL, NULL),
('1912123', 'Lê', 'Trần Hoàng', 'Thịnh', 'male', 'thinh.lebkuhcm@hcmut.edu.vn', 2001, '34B', 'Lý Thường Kiệt', 'Quận 10', 'HCM', NULL, NULL),
('1912140', 'Lê', 'Nguyễn Bảo', 'Linh', 'female', 'linh.le_nguyen@hcmut.edu.vn', 2001, '12', 'Thanh Xuân', 'Quận Thanh Xuân', 'Hà Nội', NULL, NULL),
('1912190', 'Nguyễn', 'Mai', 'Thy', 'female', 'thy.nguyen_cloudy@hcmut.edu.vn', 2001, '24/5R', 'ấp Mới 1 xã Tân Xuân', 'Huyện Hóc Môn', 'HCM', NULL, NULL),
('1912322', 'Hà', 'Minh', 'Mẫn', 'male', 'man.hahaha@gmail.com', 2012, '156', 'Nguyễn Thị Minh Khai', 'Quận 10', 'HCM', NULL, NULL),
('1915888', 'Tiêu', 'Thanh Ngọc', 'Lệ', 'female', 'le.tieu_thanh@hcmut.edu.vn', 2001, '63', 'Lạc Long Quân', 'Quận 11', 'HCM', NULL, NULL),
('2011314', 'Lê', 'Nguyễn Hoàng', 'Minh', 'male', 'minh.nguyen0201@hcmut.edu.vn', 2002, '152', 'Tô Ngọc Vân', 'Quận Thủ Đức', 'HCM', NULL, NULL),
('2012222', 'Hoàng', 'Văn', 'Tình', 'male', 'tinh.hoang1208@hcmut.edu.vn', 2002, '125', 'Lý Thường Kiệt', 'Quận 10', 'HCM', NULL, NULL),
('2013666', 'Lê', 'Nguyễn Bảo', 'Ngọc', 'female', 'ngoc.le_nguyen@hcmut.edu.vn', 2003, '12', 'Tô Ngọc Vân', 'Quận Thủ Đức', 'HCM', NULL, NULL),
('2016555', 'Hoàng', 'Thị Lệ', 'Trân', 'female', 'tran.hoang@hcmut.edu.vn', 2000, '201', 'Cộng Hòa', 'Quận 10', 'HCM', NULL, NULL),
('2111314', 'Huỳnh', 'Nguyễn Hoàng', 'Hinh', 'male', 'hinh.huynh1214@hcmut.edu.vn', 1999, '36', 'Nguyễn Thái Học', 'Quận Ba Đình', 'Hà Nội', NULL, NULL),
('5426517', 'Hà', 'Duy', 'Anh', NULL, 'anh.haduyanh@hcmut.edu.vn', 2001, '123', 'Chu Văn An', 'Krông Ana', 'Đắk Lắk', 368691668, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `hotro`
--

CREATE TABLE `hotro` (
  `lophocMaLH` varchar(255) NOT NULL,
  `trogiangNhanvien` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `hotro`
--

INSERT INTO `hotro` (`lophocMaLH`, `trogiangNhanvien`) VALUES
('KN003_L03', 'TG002'),
('OT001_L01', 'TG003'),
('OT001_L02', 'TG003'),
('TNH001_L01', 'TG004');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `khoahoc`
--

CREATE TABLE `khoahoc` (
  `MaKH` varchar(255) NOT NULL,
  `Ten` varchar(255) DEFAULT NULL,
  `Hocphi` int(11) DEFAULT NULL,
  `Noidung` varchar(255) NOT NULL,
  `Thoiluong` int(11) NOT NULL,
  `Trangthai` varchar(255) NOT NULL,
  `Gioihansiso` int(11) NOT NULL,
  `Yeucautrinhdo` int(11) NOT NULL,
  `up` tinyint(4) NOT NULL,
  `url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `khoahoc`
--

INSERT INTO `khoahoc` (`MaKH`, `Ten`, `Hocphi`, `Noidung`, `Thoiluong`, `Trangthai`, `Gioihansiso`, `Yeucautrinhdo`, `up`, `url`) VALUES
('KN001', 'Anh Ngữ Ứng Dụng English Hub', 10000000, 'Giá trị cốt lõi của English Hub là giáo trình cân bằng 4 kỹ năng Anh ngữ với kết quả học tập rõ ràng thông qua các bài học chủ đề thú vị và ngôn ngữ được trình bày bằng video đậm chất \"giải trí\".', 12, 'opening', 30, 0, 0, 'assets/img/catalog/KN001.jpeg'),
('KN002', 'Tiếng Anh Kinh Doanh', 7000000, 'Thiết kế phù hợp với yêu cầu của lĩnh vực kinh doanh để người học giao tiếp Anh ngữ thật tự tin và chuyên nghiệp, hỗ trợ tốt nhất cho công việc.', 10, 'opening', 20, 0, 0, 'assets/img/catalog/KN002.jpeg'),
('KN003', 'Anh Ngữ Giao Tiếp iTALK', 8000000, 'Mọi hoạt động trong từng buổi học thúc đẩy học viên luyện kỹ năng giao tiếp tự tin và hiệu quả ngay tại lớp\r\n\r\n', 10, 'opening', 20, 0, 0, 'assets/img/catalog/KN003.jpeg'),
('KN004', 'Anh Ngữ Cấp Tốc Cho Người \"Mất Gốc\"', 5000000, 'Xây dựng nền tảng tiếng Anh, cải thiện 4 kỹ năng từ cơ bản đến nâng cao trong thời gian ngắn với hiệu quả tối ưu.', 6, 'opening', 10, 0, 0, 'assets/img/catalog/KN004.jpeg'),
('OT001', 'Ôn Thi IELTS 6.0', 9000000, 'Đề thi thử miễn phí, đội ngũ giảng viên chuyên môn cao và tận tình mang lại hiệu quả tốt nhất cho học viên.', 12, 'opening', 25, 5, 0, 'assets/img/catalog/OT001.png'),
('OT002', 'Ôn Thi IELTS 6.5', 10000000, 'Đề thi thử miễn phí, đội ngũ giảng viên chuyên môn cao và tận tình mang lại hiệu quả tốt nhất cho học viên.', 15, 'closed', 25, 5, 0, 'assets/img/catalog/OT002.png'),
('OT003', 'Ôn Thi IELTS 7.0', 10000000, 'Đề thi thử miễn phí, đội ngũ giảng viên chuyên môn cao và tận tình mang lại hiệu quả tốt nhất cho học viên.', 12, 'opening', 25, 6, 0, 'assets/img/catalog/OT003.png'),
('OT004', 'Ôn Thi IELTS 8.0', 15000000, 'Đề thi thử miễn phí, đội ngũ giảng viên chuyên môn cao và tận tình mang lại hiệu quả tốt nhất cho học viên.', 18, 'closed', 25, 7, 0, 'assets/img/catalog/OT004.png'),
('OT005', 'Ôn Thi TOEIC 600', 7000000, 'Đề thi thử miễn phí, đội ngũ giảng viên chuyên môn cao và tận tình mang lại hiệu quả tốt nhất cho học viên.', 12, 'opening', 20, 4, 0, 'assets/img/catalog/OT005.png'),
('OT006', 'Ôn Thi TOEIC 700', 7500000, 'Đề thi thử miễn phí, đội ngũ giảng viên chuyên môn cao và tận tình mang lại hiệu quả tốt nhất cho học viên.', 14, 'opening', 20, 5, 0, 'assets/img/catalog/OT006.png'),
('OT007', 'Ôn Thi TOEIC 800', 9000000, 'Đề thi thử miễn phí, đội ngũ giảng viên chuyên môn cao và tận tình mang lại hiệu quả tốt nhất cho học viên.', 15, 'closed', 15, 7, 0, 'assets/img/catalog/OT007.png'),
('TN001', 'Anh Ngữ Thiếu Niên YOUNG LEADER', 12000000, 'Chương trình cho thiếu niên từ 11 đến 15 tuổi nhằm giúp học viên giao tiếp tiếng anh lưu loát, rèn luyện kỹ năng học tập, tự tin theo học chương trình tiếng anh ở bậc phổ thông cơ sở và đạt điểm cao trong các kỳ thi quốc tế.', 15, 'closed', 20, 0, 0, 'assets/img/catalog/TN001.jpeg'),
('TNH001', 'Anh Ngữ Mẫu Giáo SMARTKID', 10000000, 'Chương trình cho trẻ từ 4 đến 6 tuổi giúp tạo nền tảng anh ngữ vững chắc cho bé.', 18, 'opening', 25, 0, 0, 'assets/img/catalog/TNH001.jpeg'),
('TNH002', 'Anh Ngữ Thiếu Nhi SUPERKID', 10000000, 'Hình thành và phát triển ngôn ngữ như bản năng kết hợp với bồi dưỡng cho chương trình tiếng anh trên lớp.', 15, 'opening', 20, 0, 0, 'assets/img/catalog/TNH002.jpeg'),
('TNH003', 'Tiếng Anh Hè', 5000000, 'Với phương pháp học thông qua khám phá, cùng với sự hỗ trợ của công nghệ hiện đại, nội dung học đầy màu sắc và hoạt động thực hành đầy hứng khởi, con hiểu thêm về bản thân và mở khóa những vượt trội bên trong con.', 9, 'opening', 30, 0, 0, 'assets/img/catalog/TNH003.jpeg');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `khoakynang`
--

CREATE TABLE `khoakynang` (
  `Phanloai` varchar(255) NOT NULL,
  `khoahocMaKH` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `khoakynang`
--

INSERT INTO `khoakynang` (`Phanloai`, `khoahocMaKH`) VALUES
('Tiếng Anh Giao Tiếp', 'KN001'),
('Tiếng Anh Doanh Nghiệp', 'KN002'),
('Tiếng Anh Giao Tiếp', 'KN003'),
('Tiếng Anh Cơ Bản', 'KN004');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `khoaonthi`
--

CREATE TABLE `khoaonthi` (
  `Muctieu` varchar(255) NOT NULL,
  `Loaichungchi` varchar(255) NOT NULL,
  `khoahocMaKH` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `khoaonthi`
--

INSERT INTO `khoaonthi` (`Muctieu`, `Loaichungchi`, `khoahocMaKH`) VALUES
('6.0', 'IELTS', 'OT001'),
('6.5', 'IELTS', 'OT002'),
('7.0', 'IELTS', 'OT003'),
('8.0', 'IELTS', 'OT004'),
('600', 'TOEIC', 'OT005'),
('700', 'TOEIC', 'OT006'),
('800', 'TOEIC', 'OT007');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `khoathieunhi`
--

CREATE TABLE `khoathieunhi` (
  `khoahocMaKH` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `khoathieunhi`
--

INSERT INTO `khoathieunhi` (`khoahocMaKH`) VALUES
('TNH001'),
('TNH002');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `khoathieunien`
--

CREATE TABLE `khoathieunien` (
  `khoahocMaKH` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `khoathieunien`
--

INSERT INTO `khoathieunien` (`khoahocMaKH`) VALUES
('TN001');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `kynangsong_ktnien`
--

CREATE TABLE `kynangsong_ktnien` (
  `Kynangsong` varchar(255) NOT NULL,
  `khoathieunienKhoahoc` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `kynangsong_ktnien`
--

INSERT INTO `kynangsong_ktnien` (`Kynangsong`, `khoathieunienKhoahoc`) VALUES
('MC tập sự', 'TN001'),
('Tìm hiểu pháp luật', 'TN001');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `kynang_kkn`
--

CREATE TABLE `kynang_kkn` (
  `Kynang` varchar(255) NOT NULL,
  `khoakynangKhoahoc` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `kynang_kkn`
--

INSERT INTO `kynang_kkn` (`Kynang`, `khoakynangKhoahoc`) VALUES
('Nghe', 'KN001'),
('Nghe', 'KN002'),
('Nghe', 'KN003'),
('Nghe', 'KN004'),
('Nói', 'KN001'),
('Nói', 'KN002'),
('Nói', 'KN003'),
('Nói', 'KN004'),
('Viết', 'KN001'),
('Viết', 'KN004'),
('Đọc', 'KN001'),
('Đọc', 'KN004');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `lophoc`
--

CREATE TABLE `lophoc` (
  `MaLH` varchar(255) NOT NULL,
  `Ngaybatdau` datetime DEFAULT NULL,
  `Ngayketthuc` datetime DEFAULT NULL,
  `Siso` int(11) NOT NULL,
  `chinhanhMaCN` varchar(255) NOT NULL,
  `khoahocMaKH` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `lophoc`
--

INSERT INTO `lophoc` (`MaLH`, `Ngaybatdau`, `Ngayketthuc`, `Siso`, `chinhanhMaCN`, `khoahocMaKH`) VALUES
('KN001_L02', '2021-11-17 15:00:00', '2022-01-25 15:00:00', 12, 'BD001', 'KN001'),
('KN002_L05', '2021-11-08 15:00:00', '2022-01-17 15:00:00', 1, 'HCM015', 'KN002'),
('KN003_L03', '2021-09-27 15:00:00', '2021-12-05 15:00:00', 5, 'HCM015', 'KN003'),
('KN004_L01', '2020-11-01 15:00:00', '2020-12-12 15:00:00', 9, 'HCM010', 'KN004'),
('OT001_L01', '2021-09-27 15:00:00', '2021-12-19 15:00:00', 7, 'HCM009', 'OT001'),
('OT001_L02', '2021-09-27 15:00:00', '2021-12-19 15:00:00', 9, 'HCM009', 'OT001'),
('OT002_L01', '2020-09-13 15:00:00', '2020-12-26 15:00:00', 5, 'BD001', 'OT002'),
('OT002_L02', '2020-09-13 15:00:00', '2020-12-26 15:00:00', 5, 'BD001', 'OT002'),
('OT003_L01', '2021-11-20 15:00:00', '2022-01-30 15:00:00', 4, 'HCM009', 'OT003'),
('OT003_L02', '2021-11-08 15:00:00', '2022-01-30 15:00:00', 5, 'HCM009', 'OT003'),
('OT003_L03', '2021-11-08 15:00:00', '2022-01-30 15:00:00', 0, 'HCM009', 'OT003'),
('OT004_L05', '2021-11-08 15:00:00', '2022-03-14 15:00:00', 0, 'HCM009', 'OT004'),
('TN001_L05', '2021-11-08 15:00:00', '2022-02-21 15:00:00', 0, 'HCM014', 'TN001'),
('TNH001_L01', '2021-08-23 15:00:00', '2021-12-26 15:00:00', 10, 'HCM014', 'TNH001'),
('TNH001_L02', '2020-08-23 15:00:00', '2020-12-26 15:00:00', 5, 'BD001', 'TNH001'),
('TNH002', '2021-10-14 23:55:00', '2022-02-11 23:55:00', 0, 'HN002', 'TNH002'),
('TNH002_L05', '2021-11-08 15:00:00', '2022-02-21 15:00:00', 0, 'HN002', 'TNH002');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `ngoaikhoa_ktnhi`
--

CREATE TABLE `ngoaikhoa_ktnhi` (
  `Ngoaikhoa` varchar(255) NOT NULL,
  `khoathieunhiKhoahoc` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `ngoaikhoa_ktnhi`
--

INSERT INTO `ngoaikhoa_ktnhi` (`Ngoaikhoa`, `khoathieunhiKhoahoc`) VALUES
('Bé làm ngôi sao', 'TNH002'),
('Bé vào bếp', 'TNH001'),
('Ngày hội trồng cây', 'TNH002'),
('Tham quan bảo tàng', 'TNH002'),
('Tham quan thảo cầm viên', 'TNH001');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nhanvien`
--

CREATE TABLE `nhanvien` (
  `MaNV` varchar(255) NOT NULL,
  `Ho` varchar(255) NOT NULL,
  `Tendem` varchar(255) NOT NULL,
  `Ten` varchar(255) NOT NULL,
  `Namsinh` int(11) DEFAULT NULL,
  `Gioitinh` enum('male','female') DEFAULT NULL,
  `Email` varchar(255) NOT NULL,
  `Sodienthoai` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `nhanvien`
--

INSERT INTO `nhanvien` (`MaNV`, `Ho`, `Tendem`, `Ten`, `Namsinh`, `Gioitinh`, `Email`, `Sodienthoai`) VALUES
('GV001', 'Nguyễn', 'Huyền', 'Trang', 1992, 'female', 'trang.nguyen_huyen@gmail.com', 945112451),
('GV002', 'Lê', 'Thanh', 'Vân', 1993, 'female', 'van.le_thanh@gmail.com', 984123546),
('GV003', 'Nguyễn', 'Ngọc Bảo', 'Duy', 1989, 'male', 'duy.nguyennb@gmail.com', 935142178),
('GV004', 'Mai', 'Hoàng', 'Trâm', 1988, 'female', 'tram_bao@gmail.com', 954152588),
('GV005', 'Hồ', 'Trần Ngọc', 'Nguyên', 1989, 'male', 'nguyen_ho.ngoc@gmail.com', 984213157),
('QL001', 'Nguyễn', 'Thành', 'Nhân', 1979, 'male', 'nhannguyen_thanh@gmail.com', NULL),
('QL002', 'Nguyễn', 'Thanh', 'Tùng', 1985, 'male', 'tung_nguyen_thanh@gmail.com', NULL),
('QL003', 'Trần', 'Thanh', 'Tâm', 1988, 'female', 'tam_thanhtran@gmail.com', NULL),
('TG001', 'Bùi', 'Công Anh', 'Tùng', 1997, 'male', 'tung_bui@gmail.com', 954215132),
('TG002', 'Huỳnh', 'Tường', 'Vy', 1996, 'female', 'vy_huynhhuynh@gmail.com', 378454652),
('TG003', 'Nguyễn', 'Trần Hoàng', 'Huy', 1998, 'male', 'huy_hoang@gmail.com', 964512157),
('TG004', 'Văn', 'Hồ Thu', 'Nguyệt', 2001, 'female', 'vanhotn@gmail.com', 985264631);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `phuhuynh`
--

CREATE TABLE `phuhuynh` (
  `Tenphuhuynh` varchar(255) NOT NULL,
  `Namsinh` int(11) DEFAULT NULL,
  `Gioitinh` enum('male','female') DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Quanhe` varchar(255) DEFAULT NULL,
  `Sodienthoai` int(11) DEFAULT NULL,
  `hocvienMaHV` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `phuhuynh`
--

INSERT INTO `phuhuynh` (`Tenphuhuynh`, `Namsinh`, `Gioitinh`, `Email`, `Quanhe`, `Sodienthoai`, `hocvienMaHV`) VALUES
('Hà Ngọc Nguyệt', 1980, 'female', 'nguyetha@gmail.com', 'Mẹ', 372418357, '1312451'),
('Hà Đức Chinh', 1983, 'male', 'chinhha@gmail.com', 'Cha', 984513147, '1912322'),
('Lê Hoàng Dương', 1959, 'male', 'duong_le@gmail.com', 'Cha', 903567541, '1254741'),
('Lê Hoàng Dương', 1959, 'male', 'duong_le@gmail.com', 'Cha', 903567541, '1912123'),
('Lê Thanh Trúc', 1970, 'female', 'truc_thanhle@gmail.com', 'Mẹ', 965412011, '1820566'),
('Lê Văn Việt', 1969, 'male', 'viet_le@gmail.com', 'Cha', 902031154, '1910448'),
('Ngô Quang Khải', 1979, 'male', 'khai_ngoquang@gmail.com', 'Chú', 372564123, '1810227'),
('Nguyễn Thanh Ngọc', 1989, 'female', 'ngoc_thanhthanh@gmail.com', 'Cô', 965471452, '2012222'),
('Nguyễn Thanh Sơn', 1965, 'male', 'thanhsonnguyen@gmail.com', 'Cậu', 965412457, '1911704'),
('Đinh Gia Quang', 1990, 'male', 'quang_dinh@gmail.com', 'Chú', 905241245, '1412667');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `quanlygiaoduc`
--

CREATE TABLE `quanlygiaoduc` (
  `nhanvienMaNV` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `quanlygiaoduc`
--

INSERT INTO `quanlygiaoduc` (`nhanvienMaNV`) VALUES
('QL001'),
('QL002'),
('QL003');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sudung`
--

CREATE TABLE `sudung` (
  `giaotrinhMaGt` varchar(255) NOT NULL,
  `khoahocMaKH` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `sudung`
--

INSERT INTO `sudung` (`giaotrinhMaGt`, `khoahocMaKH`) VALUES
('KN001_GT01', 'KN001'),
('KN002_GT01', 'KN002'),
('KN003_GT01', 'KN003'),
('KN004_GT01', 'KN004'),
('OT001_GT01', 'OT001'),
('OT001_GT02', 'OT001'),
('OT002_GT01', 'OT002'),
('OT002_GT02', 'OT002'),
('OT002_GT03', 'OT002'),
('OT003_GT01', 'OT003'),
('OT003_GT02', 'OT003'),
('OT004_GT01', 'OT004'),
('OT004_GT02', 'OT004'),
('OT005_GT01', 'OT005'),
('OT005_GT02', 'OT005'),
('OT006_GT01', 'OT006'),
('OT007_GT02', 'OT007'),
('TN001_GT01', 'TN001'),
('TN001_GT02', 'TN001'),
('TNH001_GT01', 'TNH001'),
('TNH001_GT02', 'TNH001'),
('TNH002_GT01', 'TNH002'),
('TNH002_GT02', 'TNH002'),
('TNH002_GT02', 'TNH003');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tacgia_gt`
--

CREATE TABLE `tacgia_gt` (
  `Tacgia` varchar(255) NOT NULL,
  `giaotrinhMaGt` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `tacgia_gt`
--

INSERT INTO `tacgia_gt` (`Tacgia`, `giaotrinhMaGt`) VALUES
('Cambridge', 'OT001_GT02'),
('Cambridge', 'OT002_GT01'),
('Cambridge', 'OT002_GT02'),
('Cambridge', 'OT003_GT01'),
('Cambridge', 'OT003_GT02'),
('Cambridge', 'OT003_GT03'),
('Cambridge', 'OT004_GT01'),
('Cambridge', 'OT004_GT02'),
('Cambridge', 'OT005_GT01'),
('Cambridge', 'OT005_GT02'),
('Cambridge', 'OT006_GT01'),
('Cambridge', 'OT006_GT02'),
('Cambridge', 'OT007_GT01'),
('Cambridge', 'OT007_GT02'),
('Cambridge', 'TN001_GT01'),
('Cambridge', 'TNH001_GT01'),
('Cambridge', 'TNH001_GT02'),
('Cambridge', 'TNH002_GT01'),
('Cambridge', 'TNH002_GT02'),
('Malcolm Mann', 'OT002_GT03'),
('Nhóm giáo viên T2E', 'KN001_GT01'),
('Nhóm giáo viên T2E', 'KN002_GT01'),
('Nhóm giáo viên T2E', 'KN003_GT01'),
('Nhóm giáo viên T2E', 'KN004_GT01'),
('Nhóm giáo viên T2E', 'TN001_GT02'),
('Raymond Murphy', 'OT001_GT01');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `thoikhoabieu_lh`
--

CREATE TABLE `thoikhoabieu_lh` (
  `Ngay` enum('2','3','4','5','6','7','8') NOT NULL,
  `Giobatdau` int(11) NOT NULL,
  `Gioketthuc` int(11) NOT NULL,
  `lophocMaLH` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `thoikhoabieu_lh`
--

INSERT INTO `thoikhoabieu_lh` (`Ngay`, `Giobatdau`, `Gioketthuc`, `lophocMaLH`) VALUES
('2', 3, 5, 'OT003_L03'),
('2', 7, 9, 'OT003_L01'),
('2', 10, 12, 'OT003_L02'),
('2', 17, 19, 'KN001_L02'),
('2', 17, 19, 'OT001_L01'),
('2', 17, 19, 'OT002_L01'),
('2', 17, 19, 'OT002_L02'),
('2', 17, 19, 'TNH001_L01'),
('2', 17, 19, 'TNH001_L02'),
('3', 3, 5, 'OT004_L05'),
('3', 5, 7, 'KN002_L05'),
('3', 7, 9, 'TNH002_L05'),
('3', 10, 12, 'TN001_L05'),
('4', 3, 5, 'OT003_L03'),
('4', 7, 9, 'OT003_L01'),
('4', 10, 12, 'OT003_L02'),
('4', 17, 19, 'KN001_L02'),
('4', 17, 19, 'OT001_L01'),
('4', 17, 19, 'OT002_L01'),
('4', 17, 19, 'OT002_L02'),
('4', 17, 19, 'TNH001_L01'),
('4', 17, 19, 'TNH001_L02'),
('5', 3, 5, 'OT004_L05'),
('5', 5, 7, 'KN002_L05'),
('5', 7, 9, 'TNH002_L05'),
('5', 10, 12, 'TN001_L05'),
('6', 3, 5, 'OT003_L03'),
('6', 7, 9, 'OT003_L01'),
('6', 10, 12, 'OT003_L02'),
('6', 17, 19, 'KN001_L02'),
('6', 17, 19, 'OT001_L01'),
('6', 17, 19, 'OT002_L01'),
('6', 17, 19, 'OT002_L02'),
('6', 17, 19, 'TNH001_L01'),
('6', 17, 19, 'TNH001_L02'),
('7', 1, 4, 'KN004_L01'),
('7', 3, 5, 'OT004_L05'),
('7', 5, 7, 'KN002_L05'),
('7', 7, 9, 'TNH002_L05'),
('7', 7, 10, 'KN003_L03'),
('7', 7, 10, 'OT001_L02'),
('7', 10, 12, 'TN001_L05'),
('8', 1, 4, 'KN004_L01'),
('8', 7, 10, 'KN003_L03'),
('8', 7, 10, 'OT001_L02');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `trinhdo_gv`
--

CREATE TABLE `trinhdo_gv` (
  `trinhdo` varchar(255) NOT NULL,
  `giaovienNhanvien` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `trinhdo_gv`
--

INSERT INTO `trinhdo_gv` (`trinhdo`, `giaovienNhanvien`) VALUES
('Cử nhân Kinh doanh Quốc tế', 'GV002'),
('Cử nhân ngôn ngữ anh', 'GV003'),
('Cử nhân sư phạm anh', 'GV004'),
('Thạc sĩ Ngôn ngữ học', 'GV001'),
('Thạc sĩ Ngôn ngữ học', 'GV002'),
('Thạc sĩ Ngôn ngữ học', 'GV005');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `trinhdo_hv`
--

CREATE TABLE `trinhdo_hv` (
  `Diem` int(11) NOT NULL,
  `Ngaycapnhat` datetime NOT NULL,
  `hocvienMaHV` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `trinhdo_hv`
--

INSERT INTO `trinhdo_hv` (`Diem`, `Ngaycapnhat`, `hocvienMaHV`) VALUES
(0, '2021-05-01 15:00:00', '1254741'),
(0, '2021-05-01 15:00:00', '1312451'),
(0, '2021-05-01 15:00:00', '1514001'),
(0, '2021-05-01 15:00:00', '1514002'),
(0, '2021-05-01 15:00:00', '1611204'),
(0, '2021-05-01 15:00:00', '1611314'),
(0, '2021-05-01 15:00:00', '1623445'),
(0, '2021-05-01 15:00:00', '1623558'),
(0, '2021-05-01 15:00:00', '1710512'),
(0, '2021-05-01 15:00:00', '1810333'),
(0, '2021-05-01 15:00:00', '1811314'),
(0, '2021-05-01 15:00:00', '1845621'),
(0, '2021-05-01 15:00:00', '1910448'),
(0, '2021-05-01 15:00:00', '1910666'),
(0, '2021-05-01 15:00:00', '1911837'),
(0, '2021-05-01 15:00:00', '1911900'),
(0, '2021-05-01 15:00:00', '1912140'),
(0, '2021-05-01 15:00:00', '1912190'),
(0, '2021-05-01 15:00:00', '1912322'),
(0, '2021-05-01 15:00:00', '2011314'),
(0, '2021-05-01 15:00:00', '2012222'),
(5, '2021-05-01 15:00:00', '1021000'),
(5, '2021-05-01 15:00:00', '1311004'),
(5, '2021-05-01 15:00:00', '1712005'),
(5, '2021-05-01 15:00:00', '1911314'),
(5, '2021-11-14 06:20:22', '1911314'),
(6, '2021-05-01 15:00:00', '1412667'),
(6, '2021-05-01 15:00:00', '1611000'),
(6, '2021-05-01 15:00:00', '1711314'),
(6, '2021-05-01 15:00:00', '2013666'),
(7, '2021-05-01 15:00:00', '1912123'),
(7, '2021-05-01 15:00:00', '1915888'),
(8, '2021-05-01 15:00:00', '1514226'),
(8, '2021-05-01 15:00:00', '1593031'),
(8, '2021-05-01 15:00:00', '1612224'),
(8, '2021-05-01 15:00:00', '1810227'),
(8, '2021-05-01 15:00:00', '1820566'),
(8, '2021-05-01 15:00:00', '1911704'),
(8, '2021-05-01 15:00:00', '2016555');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `trinhdo_tg`
--

CREATE TABLE `trinhdo_tg` (
  `trinhdo` int(11) NOT NULL,
  `trogiangNhanvien` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `trinhdo_tg`
--

INSERT INTO `trinhdo_tg` (`trinhdo`, `trogiangNhanvien`) VALUES
(7, 'TG001'),
(7, 'TG003'),
(8, 'TG002'),
(8, 'TG004');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `trogiang`
--

CREATE TABLE `trogiang` (
  `Kinhnghiem` int(11) NOT NULL,
  `nhanvienMaNV` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `trogiang`
--

INSERT INTO `trogiang` (`Kinhnghiem`, `nhanvienMaNV`) VALUES
(12, 'TG001'),
(10, 'TG002'),
(18, 'TG003'),
(15, 'TG004');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_nv`
--

CREATE TABLE `user_nv` (
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nhanvienMaNV` varchar(255) DEFAULT NULL,
  `role` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `user_nv`
--

INSERT INTO `user_nv` (`username`, `password`, `nhanvienMaNV`, `role`) VALUES
('admin', '$2b$15$2DWQPTbx93BSKwRy/3cnF.jQzSRpeR1vFmXjMX0IONqYFAQrAK.42', NULL, 0),
('giangvien', '$2b$15$pEvw.89vWvl2C0zBKX2sQu.hP6nBJl5i03cPdsZAngsbFBoutS7aK', 'GV001', 2),
('quanlygiaoduc', '$2b$15$aV.z0p/2upyh3uc0e1/3LOTD1RHesE8c2BVqO3RmgUqFxUmSt19MG', 'QL001', 3);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `uudai_kh`
--

CREATE TABLE `uudai_kh` (
  `Uudai` varchar(255) NOT NULL,
  `khoahocMaKH` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `uudai_kh`
--

INSERT INTO `uudai_kh` (`Uudai`, `khoahocMaKH`) VALUES
('Bộ tài liệu độc quyền', 'KN002'),
('Bộ tài liệu độc quyền', 'KN004'),
('Bộ đề ôn thi độc quyền', 'OT001'),
('Bộ đề ôn thi độc quyền', 'OT002'),
('Bộ đề ôn thi độc quyền', 'OT003'),
('Bộ đề ôn thi độc quyền', 'OT004'),
('Bộ đề ôn thi độc quyền', 'OT005'),
('Bộ đề ôn thi độc quyền', 'OT006'),
('Bộ đề ôn thi độc quyền', 'OT007'),
('Combo phim hoạt hình tiếng anh ', 'TNH001'),
('Combo phim hoạt hình tiếng anh ', 'TNH002'),
('Miễn phí 2 tháng Nextflix', 'KN001'),
('Tặng 2 vé xem phim CGV', 'TN001'),
('Tặng 2 vé đến khu vui chơi thiếu nhi', 'TNH001'),
('Tặng 2 vé đến khu vui chơi thiếu nhi', 'TNH002');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `chinhanh`
--
ALTER TABLE `chinhanh`
  ADD PRIMARY KEY (`MaCN`);

--
-- Chỉ mục cho bảng `congtac_gv`
--
ALTER TABLE `congtac_gv`
  ADD PRIMARY KEY (`giaovienNhanvien`,`chinhanhMaCN`),
  ADD KEY `FK_525f724bef45f05be0c0d92b570` (`chinhanhMaCN`);

--
-- Chỉ mục cho bảng `congtac_tg`
--
ALTER TABLE `congtac_tg`
  ADD PRIMARY KEY (`trogiangNhanvien`,`chinhanhMaCN`),
  ADD KEY `FK_ddb886f8a1e192bb7c2707daf32` (`chinhanhMaCN`);

--
-- Chỉ mục cho bảng `dangky`
--
ALTER TABLE `dangky`
  ADD PRIMARY KEY (`lophocMaLH`,`hocvienMaHV`),
  ADD KEY `FK_6b62085fca4de512e228b138139` (`hocvienMaHV`);

--
-- Chỉ mục cho bảng `danhgia_kh`
--
ALTER TABLE `danhgia_kh`
  ADD PRIMARY KEY (`Ten`,`Noidung`,`khoahocMaKH`),
  ADD KEY `FK_ee7c585f415bc4e45335f2528d0` (`khoahocMaKH`);

--
-- Chỉ mục cho bảng `dieuchinh_kh`
--
ALTER TABLE `dieuchinh_kh`
  ADD PRIMARY KEY (`khoahocMaKH`,`quanlygiaoducNhanvien`),
  ADD KEY `FK_80fe5395786faef754a2187c201` (`quanlygiaoducNhanvien`);

--
-- Chỉ mục cho bảng `dieuchinh_lh`
--
ALTER TABLE `dieuchinh_lh`
  ADD PRIMARY KEY (`lophocMaLH`,`quanlygiaoducNhanvien`),
  ADD KEY `FK_e91e575c611fe99ca22791676ec` (`quanlygiaoducNhanvien`);

--
-- Chỉ mục cho bảng `doituong_kh`
--
ALTER TABLE `doituong_kh`
  ADD PRIMARY KEY (`Doituong`,`khoahocMaKH`),
  ADD KEY `FK_516beb3bdfde023da42a8dcbef5` (`khoahocMaKH`);

--
-- Chỉ mục cho bảng `giangday`
--
ALTER TABLE `giangday`
  ADD PRIMARY KEY (`lophocMaLH`,`giaovienNhanvien`),
  ADD KEY `FK_d39954249482c1c52b629b5bfc8` (`giaovienNhanvien`);

--
-- Chỉ mục cho bảng `giaotrinh`
--
ALTER TABLE `giaotrinh`
  ADD PRIMARY KEY (`MaGT`);

--
-- Chỉ mục cho bảng `giaovien`
--
ALTER TABLE `giaovien`
  ADD PRIMARY KEY (`nhanvienMaNV`),
  ADD UNIQUE KEY `REL_02723c428507a94ee502f89fa1` (`nhanvienMaNV`);

--
-- Chỉ mục cho bảng `hocvien`
--
ALTER TABLE `hocvien`
  ADD PRIMARY KEY (`MaHV`),
  ADD UNIQUE KEY `IDX_bd54f51ef7abeeae790a50464f` (`Email`);

--
-- Chỉ mục cho bảng `hotro`
--
ALTER TABLE `hotro`
  ADD PRIMARY KEY (`lophocMaLH`,`trogiangNhanvien`),
  ADD KEY `FK_e8721d35d9608d5cd4ca825ab05` (`trogiangNhanvien`);

--
-- Chỉ mục cho bảng `khoahoc`
--
ALTER TABLE `khoahoc`
  ADD PRIMARY KEY (`MaKH`);

--
-- Chỉ mục cho bảng `khoakynang`
--
ALTER TABLE `khoakynang`
  ADD PRIMARY KEY (`khoahocMaKH`),
  ADD UNIQUE KEY `REL_1337f52ed485813ca294d4de41` (`khoahocMaKH`);

--
-- Chỉ mục cho bảng `khoaonthi`
--
ALTER TABLE `khoaonthi`
  ADD PRIMARY KEY (`khoahocMaKH`),
  ADD UNIQUE KEY `REL_c50ca00f7334a889e0e6a8a634` (`khoahocMaKH`);

--
-- Chỉ mục cho bảng `khoathieunhi`
--
ALTER TABLE `khoathieunhi`
  ADD PRIMARY KEY (`khoahocMaKH`),
  ADD UNIQUE KEY `REL_161c07f720ec4c5038c5f39c8f` (`khoahocMaKH`);

--
-- Chỉ mục cho bảng `khoathieunien`
--
ALTER TABLE `khoathieunien`
  ADD PRIMARY KEY (`khoahocMaKH`),
  ADD UNIQUE KEY `REL_5132ee55a49b6b5b3ab2a21c42` (`khoahocMaKH`);

--
-- Chỉ mục cho bảng `kynangsong_ktnien`
--
ALTER TABLE `kynangsong_ktnien`
  ADD PRIMARY KEY (`Kynangsong`,`khoathieunienKhoahoc`),
  ADD KEY `FK_e81d7247e17c4d2f552255b4f7a` (`khoathieunienKhoahoc`);

--
-- Chỉ mục cho bảng `kynang_kkn`
--
ALTER TABLE `kynang_kkn`
  ADD PRIMARY KEY (`Kynang`,`khoakynangKhoahoc`),
  ADD KEY `FK_2d3acf630a4432e39be6654ed54` (`khoakynangKhoahoc`);

--
-- Chỉ mục cho bảng `lophoc`
--
ALTER TABLE `lophoc`
  ADD PRIMARY KEY (`MaLH`),
  ADD KEY `FK_2889ce55a25179d8d4bf4f584f6` (`chinhanhMaCN`),
  ADD KEY `FK_5e7f589642455ca7b806fa3a1b5` (`khoahocMaKH`);

--
-- Chỉ mục cho bảng `ngoaikhoa_ktnhi`
--
ALTER TABLE `ngoaikhoa_ktnhi`
  ADD PRIMARY KEY (`Ngoaikhoa`,`khoathieunhiKhoahoc`),
  ADD KEY `FK_13ada0db29db81d9194fa80d2ef` (`khoathieunhiKhoahoc`);

--
-- Chỉ mục cho bảng `nhanvien`
--
ALTER TABLE `nhanvien`
  ADD PRIMARY KEY (`MaNV`);

--
-- Chỉ mục cho bảng `phuhuynh`
--
ALTER TABLE `phuhuynh`
  ADD PRIMARY KEY (`Tenphuhuynh`,`hocvienMaHV`),
  ADD UNIQUE KEY `REL_da8d2cbef3782f34eadc16baf9` (`hocvienMaHV`);

--
-- Chỉ mục cho bảng `quanlygiaoduc`
--
ALTER TABLE `quanlygiaoduc`
  ADD PRIMARY KEY (`nhanvienMaNV`),
  ADD UNIQUE KEY `REL_99f3709bdc18fab85c24ea3652` (`nhanvienMaNV`);

--
-- Chỉ mục cho bảng `sudung`
--
ALTER TABLE `sudung`
  ADD PRIMARY KEY (`giaotrinhMaGt`,`khoahocMaKH`),
  ADD KEY `FK_ce5920322e06a3aa1840f8f833f` (`khoahocMaKH`);

--
-- Chỉ mục cho bảng `tacgia_gt`
--
ALTER TABLE `tacgia_gt`
  ADD PRIMARY KEY (`Tacgia`,`giaotrinhMaGt`),
  ADD KEY `FK_dc83529571e8f71f9f5118788b7` (`giaotrinhMaGt`);

--
-- Chỉ mục cho bảng `thoikhoabieu_lh`
--
ALTER TABLE `thoikhoabieu_lh`
  ADD PRIMARY KEY (`Ngay`,`Giobatdau`,`Gioketthuc`,`lophocMaLH`),
  ADD KEY `FK_58e52af8996a3823c68dc49455b` (`lophocMaLH`);

--
-- Chỉ mục cho bảng `trinhdo_gv`
--
ALTER TABLE `trinhdo_gv`
  ADD PRIMARY KEY (`trinhdo`,`giaovienNhanvien`),
  ADD KEY `FK_03f502e3eb956b3ce04df150ac1` (`giaovienNhanvien`);

--
-- Chỉ mục cho bảng `trinhdo_hv`
--
ALTER TABLE `trinhdo_hv`
  ADD PRIMARY KEY (`Diem`,`Ngaycapnhat`,`hocvienMaHV`),
  ADD KEY `FK_1cd56f52a3fc84ec0b9eacd2fd4` (`hocvienMaHV`);

--
-- Chỉ mục cho bảng `trinhdo_tg`
--
ALTER TABLE `trinhdo_tg`
  ADD PRIMARY KEY (`trinhdo`,`trogiangNhanvien`),
  ADD KEY `FK_5291ca38f71705c34ac4f0b7e8e` (`trogiangNhanvien`);

--
-- Chỉ mục cho bảng `trogiang`
--
ALTER TABLE `trogiang`
  ADD PRIMARY KEY (`nhanvienMaNV`),
  ADD UNIQUE KEY `REL_d12e94fe17a8d7315211dfd353` (`nhanvienMaNV`);

--
-- Chỉ mục cho bảng `user_nv`
--
ALTER TABLE `user_nv`
  ADD PRIMARY KEY (`username`),
  ADD UNIQUE KEY `REL_5f5b55cf316de25c33e55ee3e8` (`nhanvienMaNV`),
  ADD UNIQUE KEY `IDX_5f5b55cf316de25c33e55ee3e8` (`nhanvienMaNV`);

--
-- Chỉ mục cho bảng `uudai_kh`
--
ALTER TABLE `uudai_kh`
  ADD PRIMARY KEY (`Uudai`,`khoahocMaKH`),
  ADD KEY `FK_77de4f29fba7438a5b10df38377` (`khoahocMaKH`);

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `congtac_gv`
--
ALTER TABLE `congtac_gv`
  ADD CONSTRAINT `FK_3a8ef7e782df329315bfd14ac41` FOREIGN KEY (`giaovienNhanvien`) REFERENCES `giaovien` (`nhanvienMaNV`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_525f724bef45f05be0c0d92b570` FOREIGN KEY (`chinhanhMaCN`) REFERENCES `chinhanh` (`MaCN`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `congtac_tg`
--
ALTER TABLE `congtac_tg`
  ADD CONSTRAINT `FK_bb3f00c20461764dcebcdfcf582` FOREIGN KEY (`trogiangNhanvien`) REFERENCES `trogiang` (`nhanvienMaNV`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ddb886f8a1e192bb7c2707daf32` FOREIGN KEY (`chinhanhMaCN`) REFERENCES `chinhanh` (`MaCN`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `dangky`
--
ALTER TABLE `dangky`
  ADD CONSTRAINT `FK_6b62085fca4de512e228b138139` FOREIGN KEY (`hocvienMaHV`) REFERENCES `hocvien` (`MaHV`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_c7498309f9f4d24550333563f45` FOREIGN KEY (`lophocMaLH`) REFERENCES `lophoc` (`MaLH`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `danhgia_kh`
--
ALTER TABLE `danhgia_kh`
  ADD CONSTRAINT `FK_ee7c585f415bc4e45335f2528d0` FOREIGN KEY (`khoahocMaKH`) REFERENCES `khoahoc` (`MaKH`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `dieuchinh_kh`
--
ALTER TABLE `dieuchinh_kh`
  ADD CONSTRAINT `FK_6d9d6ef5c13d6da75076e968b19` FOREIGN KEY (`khoahocMaKH`) REFERENCES `khoahoc` (`MaKH`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_80fe5395786faef754a2187c201` FOREIGN KEY (`quanlygiaoducNhanvien`) REFERENCES `quanlygiaoduc` (`nhanvienMaNV`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `dieuchinh_lh`
--
ALTER TABLE `dieuchinh_lh`
  ADD CONSTRAINT `FK_24beb1b765ecc540899abc65736` FOREIGN KEY (`lophocMaLH`) REFERENCES `lophoc` (`MaLH`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_e91e575c611fe99ca22791676ec` FOREIGN KEY (`quanlygiaoducNhanvien`) REFERENCES `quanlygiaoduc` (`nhanvienMaNV`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `doituong_kh`
--
ALTER TABLE `doituong_kh`
  ADD CONSTRAINT `FK_516beb3bdfde023da42a8dcbef5` FOREIGN KEY (`khoahocMaKH`) REFERENCES `khoahoc` (`MaKH`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `giangday`
--
ALTER TABLE `giangday`
  ADD CONSTRAINT `FK_aebe69afdd354c9a1f4a3025b99` FOREIGN KEY (`lophocMaLH`) REFERENCES `lophoc` (`MaLH`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_d39954249482c1c52b629b5bfc8` FOREIGN KEY (`giaovienNhanvien`) REFERENCES `giaovien` (`nhanvienMaNV`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `giaovien`
--
ALTER TABLE `giaovien`
  ADD CONSTRAINT `FK_02723c428507a94ee502f89fa1a` FOREIGN KEY (`nhanvienMaNV`) REFERENCES `nhanvien` (`MaNV`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `hotro`
--
ALTER TABLE `hotro`
  ADD CONSTRAINT `FK_34a145d82fe8a264a046da31f23` FOREIGN KEY (`lophocMaLH`) REFERENCES `lophoc` (`MaLH`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_e8721d35d9608d5cd4ca825ab05` FOREIGN KEY (`trogiangNhanvien`) REFERENCES `trogiang` (`nhanvienMaNV`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `khoakynang`
--
ALTER TABLE `khoakynang`
  ADD CONSTRAINT `FK_1337f52ed485813ca294d4de410` FOREIGN KEY (`khoahocMaKH`) REFERENCES `khoahoc` (`MaKH`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `khoaonthi`
--
ALTER TABLE `khoaonthi`
  ADD CONSTRAINT `FK_c50ca00f7334a889e0e6a8a6346` FOREIGN KEY (`khoahocMaKH`) REFERENCES `khoahoc` (`MaKH`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `khoathieunhi`
--
ALTER TABLE `khoathieunhi`
  ADD CONSTRAINT `FK_161c07f720ec4c5038c5f39c8f5` FOREIGN KEY (`khoahocMaKH`) REFERENCES `khoahoc` (`MaKH`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `khoathieunien`
--
ALTER TABLE `khoathieunien`
  ADD CONSTRAINT `FK_5132ee55a49b6b5b3ab2a21c42f` FOREIGN KEY (`khoahocMaKH`) REFERENCES `khoahoc` (`MaKH`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `kynangsong_ktnien`
--
ALTER TABLE `kynangsong_ktnien`
  ADD CONSTRAINT `FK_e81d7247e17c4d2f552255b4f7a` FOREIGN KEY (`khoathieunienKhoahoc`) REFERENCES `khoathieunien` (`khoahocMaKH`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `kynang_kkn`
--
ALTER TABLE `kynang_kkn`
  ADD CONSTRAINT `FK_2d3acf630a4432e39be6654ed54` FOREIGN KEY (`khoakynangKhoahoc`) REFERENCES `khoakynang` (`khoahocMaKH`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `lophoc`
--
ALTER TABLE `lophoc`
  ADD CONSTRAINT `FK_2889ce55a25179d8d4bf4f584f6` FOREIGN KEY (`chinhanhMaCN`) REFERENCES `chinhanh` (`MaCN`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_5e7f589642455ca7b806fa3a1b5` FOREIGN KEY (`khoahocMaKH`) REFERENCES `khoahoc` (`MaKH`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `ngoaikhoa_ktnhi`
--
ALTER TABLE `ngoaikhoa_ktnhi`
  ADD CONSTRAINT `FK_13ada0db29db81d9194fa80d2ef` FOREIGN KEY (`khoathieunhiKhoahoc`) REFERENCES `khoathieunhi` (`khoahocMaKH`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `phuhuynh`
--
ALTER TABLE `phuhuynh`
  ADD CONSTRAINT `FK_da8d2cbef3782f34eadc16baf9d` FOREIGN KEY (`hocvienMaHV`) REFERENCES `hocvien` (`MaHV`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `quanlygiaoduc`
--
ALTER TABLE `quanlygiaoduc`
  ADD CONSTRAINT `FK_99f3709bdc18fab85c24ea36528` FOREIGN KEY (`nhanvienMaNV`) REFERENCES `nhanvien` (`MaNV`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `sudung`
--
ALTER TABLE `sudung`
  ADD CONSTRAINT `FK_96b0b5d45df388573e46b72790e` FOREIGN KEY (`giaotrinhMaGt`) REFERENCES `giaotrinh` (`MaGT`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ce5920322e06a3aa1840f8f833f` FOREIGN KEY (`khoahocMaKH`) REFERENCES `khoahoc` (`MaKH`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `tacgia_gt`
--
ALTER TABLE `tacgia_gt`
  ADD CONSTRAINT `FK_dc83529571e8f71f9f5118788b7` FOREIGN KEY (`giaotrinhMaGt`) REFERENCES `giaotrinh` (`MaGT`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `thoikhoabieu_lh`
--
ALTER TABLE `thoikhoabieu_lh`
  ADD CONSTRAINT `FK_58e52af8996a3823c68dc49455b` FOREIGN KEY (`lophocMaLH`) REFERENCES `lophoc` (`MaLH`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `trinhdo_gv`
--
ALTER TABLE `trinhdo_gv`
  ADD CONSTRAINT `FK_03f502e3eb956b3ce04df150ac1` FOREIGN KEY (`giaovienNhanvien`) REFERENCES `giaovien` (`nhanvienMaNV`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `trinhdo_hv`
--
ALTER TABLE `trinhdo_hv`
  ADD CONSTRAINT `FK_1cd56f52a3fc84ec0b9eacd2fd4` FOREIGN KEY (`hocvienMaHV`) REFERENCES `hocvien` (`MaHV`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `trinhdo_tg`
--
ALTER TABLE `trinhdo_tg`
  ADD CONSTRAINT `FK_5291ca38f71705c34ac4f0b7e8e` FOREIGN KEY (`trogiangNhanvien`) REFERENCES `trogiang` (`nhanvienMaNV`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `trogiang`
--
ALTER TABLE `trogiang`
  ADD CONSTRAINT `FK_d12e94fe17a8d7315211dfd353f` FOREIGN KEY (`nhanvienMaNV`) REFERENCES `nhanvien` (`MaNV`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `user_nv`
--
ALTER TABLE `user_nv`
  ADD CONSTRAINT `FK_5f5b55cf316de25c33e55ee3e85` FOREIGN KEY (`nhanvienMaNV`) REFERENCES `nhanvien` (`MaNV`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `uudai_kh`
--
ALTER TABLE `uudai_kh`
  ADD CONSTRAINT `FK_77de4f29fba7438a5b10df38377` FOREIGN KEY (`khoahocMaKH`) REFERENCES `khoahoc` (`MaKH`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
