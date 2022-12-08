$('#TAB-students').DataTable({
    "responsive": true, "lengthChange": false, "autoWidth": false, "searching": false, "bPaginate": false, "dom": "lfrti",
    language: {
        url: "//cdn.datatables.net/plug-ins/1.10.25/i18n/Vietnamese.json"
    } ,
    columnDefs: [
        { orderable: false,
             targets: 6
            }
      ]
    })
    $( document ).ready(function() {

        $.post('/thoikhoabieu/getdata', { }, function (data) {
            console.log(data);
        table = $('#TAB-students').DataTable();
        table.clear().draw();
        var thu2 ="";
        var thu3="";
        var thu4="";
        var thu5="";
        var thu6="";
        var thu7="";
        var chunhat="";
            for (var i = 0; i < data.length; i++) {
                if (data[i].Giobatdau < 12){

                    if(data[i].Ngay == '2') {
                        thu2 += data[i].Giobatdau + " giờ -" + data[i].Gioketthuc + " giờ</br>";
                    }
                    if(data[i].Ngay == '3') {
                        thu3 += data[i].Giobatdau + " giờ -" + data[i].Gioketthuc + " giờ</br>";
                    }
                    if(data[i].Ngay == '4') {
                        thu4 += data[i].Giobatdau + " giờ -" + data[i].Gioketthuc + " giờ</br>";
                    }
                    if(data[i].Ngay == '5') {
                        thu5 += data[i].Giobatdau + " giờ -" + data[i].Gioketthuc + " giờ</br>";
                    }
                    if(data[i].Ngay == '6') {
                        thu6 += data[i].Giobatdau + " giờ -" + data[i].Gioketthuc + " giờ</br>";
                    }
                    if(data[i].Ngay == '7') {
                        thu7 += data[i].Giobatdau + " giờ -" + data[i].Gioketthuc + " giờ</br>";
                    }
                    if(data[i].Ngay == '8') {
                        chunhat += data[i].Giobatdau + " giờ -" + data[i].Gioketthuc + " giờ</br>";
                    }
                    

                }
            }
            table.row.add([
                `<center><td> ${thu2} </td></center>`,
                `<center><td> ${thu3}</td></center>`,
                `<center><td>${thu4} </td></center>`,
                `<center><td>${thu5} </td></center>`,
                `<center><td> ${thu6}</td></center>`,
                `<center><td> ${thu7}</td></center>`,
                `<center><td>${chunhat} </td></center>`,
              ])
              .draw(false);
              
              var thu2 ="";
        var thu3="";
        var thu4="";
        var thu5="";
        var thu6="";
        var thu7="";
        var chunhat="";
            for (var i = 0; i < data.length; i++) {
                if (data[i].Giobatdau >= 12){

                    if(data[i].Ngay == '2') {
                        thu2 += data[i].Giobatdau + " giờ -" + data[i].Gioketthuc + " giờ</br>";
                    }
                    if(data[i].Ngay == '3') {
                        thu3 += data[i].Giobatdau + " giờ -" + data[i].Gioketthuc + " giờ</br>";
                    }
                    if(data[i].Ngay == '4') {
                        thu4 += data[i].Giobatdau + " giờ -" + data[i].Gioketthuc + " giờ</br>";
                    }
                    if(data[i].Ngay == '5') {
                        thu5 += data[i].Giobatdau + " giờ -" + data[i].Gioketthuc + " giờ</br>";
                    }
                    if(data[i].Ngay == '6') {
                        thu6 += data[i].Giobatdau + " giờ -" + data[i].Gioketthuc + " giờ</br>";
                    }
                    if(data[i].Ngay == '7') {
                        thu7 += data[i].Giobatdau + " giờ -" + data[i].Gioketthuc + " giờ</br>";
                    }
                    if(data[i].Ngay == '8') {
                        chunhat += data[i].Giobatdau + " giờ -" + data[i].Gioketthuc + " giờ</br>";
                    }
                    

                }
            }
            table.row.add([
                `<center><td> ${thu2} </td></center>`,
                `<center><td> ${thu3}</td></center>`,
                `<center><td>${thu4} </td></center>`,
                `<center><td>${thu5} </td></center>`,
                `<center><td> ${thu6}</td></center>`,
                `<center><td> ${thu7}</td></center>`,
                `<center><td>${chunhat} </td></center>`,
              ])
              .draw(false);
    })
    });
