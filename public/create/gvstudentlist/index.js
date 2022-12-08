
$('#TAB-students').DataTable({
    "responsive": true, "lengthChange": false, "autoWidth": false, "searching": false,
    language: {
        url: "//cdn.datatables.net/plug-ins/1.10.25/i18n/Vietnamese.json"
    } ,
    columnDefs: [
        { orderable: false,
             targets: 4
            }
      ]
    })
    $('.btn-search').click(function (e) {
    e.preventDefault();
    var ma = $('#malh').val();
    $.post('/dshopvien/getdshocvien', { MaLH: ma }, function (data) {
        console.log(data[0]);
        if(data[0][0].Result=="Lớp học này không do bạn phụ trách"){
            window.alert("Lớp học này không do bạn phụ trách");
        }else{
            if ($.fn.dataTable.isDataTable('#TAB-students')) {
                table = $('#TAB-students').DataTable();
                table.clear().draw();
                for (var i = 0; i < data[0].length; i++) {
                  table.row
                    .add([
                      `<center><td> ${data[0][i].mahv}  </td></center>`,
                      `<center><td> ${data[0][i].ho}</td></center>`,
                      `<center><td> ${data[0][i].tendem}</td></center>`,
                       `<center><td> ${data[0][i].ten}</td></center>`,
                       `<center><td> ${data[0][i].Tuoi}</td></center>`,
                    ])
                    .draw(false);
                }
            }
        }

    })



})