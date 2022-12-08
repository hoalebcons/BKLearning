$(".btn-search").click(function (e) {
    var MaKH = $(this).data("makh");
    $("#Addsudung input[name='MaKH']").val(MaKH);


    
    $.post("/capnhatkh/data_gt_tg", { MaKH: MaKH }, function (list) {
        var t = $('.gv_th_Modal').DataTable({
            "searching": false, // false to disable search (or any other option)
            "bDestroy": true
            });
        t.rows().remove().draw();
        for (var i = 0; i < list.listgv[0].length; i++) {
            t.row
            .add([ 

            `<center><td> ${list.listgv[0][i].MaGiaoVien}</td></center>`,                                                             
            `<center><td>   ${list.listgv[0][i].HoGV}  ${list.listgv[0][i].TendemGV}  ${list.listgv[0][i].TenGV}</td></center>`,
            `<center><td>  X</td></center>`,  
            `<center><td>  </td></center>`,  
            ])
            .draw(false);
        
        }
        for (var i = 0; i < list.listtg[0].length; i++) {
            t.row
            .add([ 
 
            `<center><td> ${list.listtg[0][i].MaTroGiang}</td></center>`,                                                             
            `<center><td>   ${list.listtg[0][i].HoTG}  ${list.listtg[0][i].TendemTG}  ${list.listtg[0][i].TenTG}</td></center>`,
            `<center><td>  </td></center>`,  
            `<center><td>  X</td></center>`,  
            ])
            .draw(false);
        
        }
    });  

    // `<center ><td > ${list.listtg[0][i].TenTG} </td></center>`,










    $('#Addsudung').modal('show');
});

$('.btn-search2').click(function (e) {
    var ma = $(this).data("makh");
    $("#giaotrinh input[name='MaKH']").val(ma);

    $.post('/capnhatgt/getAllgt', { MaKH: ma }, function (data) {
        var t = $('.giaotrinhofkh').DataTable({
            "searching": false, // false to disable search (or any other option)
            "bDestroy": true
            });
        t.rows().remove().draw();

      if ($.fn.dataTable.isDataTable('.giaotrinhofkh')) {
        table = $('.giaotrinhofkh').DataTable();
        table.clear().draw();
        for (var i = 0; i < data[0].length; i++) {
          table.row
            .add([
              `<center><td> ${data[0][i].MaGT}  </td></center>`,
              `<center><td> ${data[0][i].Ten}</td></center>`,
              `<center><td> ${data[0][i].Namxuatban}</td></center>`,
            ])
            .draw(false);
        }
      } 
    });
    $('#giaotrinh').modal('show');
  });

