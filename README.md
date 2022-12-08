# English-register



drop procedure sudung_insert;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sudung_insert`(IN `maGT` VARCHAR(255), IN `maKH` varchar(255))
begin
    if ((select count(*) from `sudung` where khoahocMaKH = MaKH) = 3) then 
		select 'Khoá học này đã sử dụng 3 giáo trình.' as 'Result';
    else insert into `sudung` values (maGT, maKH);
    end if;
        
END$$
DELIMITER ;



DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sudung_delete`(IN `maGT` VARCHAR(255), IN `maKH` varchar(255))
begin
    if ((select count(*) from `sudung` where khoahocMaKH = MaKH) = 1) then 
		select 'Khoá học phải sử dụng ít nhất 1 giáo trình.' as '';
    else delete from `sudung` where khoahocMaKH = makh and giaotrinhmagt = magt;
    end if;
   
END$$
DELIMITER ;



DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DanhsachToanboGiaotrinh`()
begin
    select * from giaotrinh;   
END$$
DELIMITER ;