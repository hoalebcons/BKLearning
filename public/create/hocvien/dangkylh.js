document.write('<script src="../../moment/moment.min.js"></script>');

const element = $(".btn-search")
element.click();

window.onload=function(){
  document.getElementById("search-btn").click();
};












$('.btn-search').click(function (e) {
  var ma = $('#makh').val();
  // var td  = document.getElementsByTagName("td");
  // var j = 0 ;
  // while(td[0]){
  //     var farther = td[0].parentNode;
  //     farther.removeChild(td[0]);
  // }

  $.post('/dangkylh/getAlllh', { MaKH: ma }, function (data) {
    // console.log(data.list2[0]);
    $('.giaotrinhofkh').attr('style', 'display:block');
    if ($.fn.dataTable.isDataTable('.giaotrinhofkh')) {
      table = $('.giaotrinhofkh').DataTable();
      table.clear().draw();
      for (var i = 0; i < data.list[0].length; i++) {

        var tkb ="";
        for (var j = 0; j < data.list2[0].length; j++){
          // console.log(data.list[0][i].MaLH, data.list2[0][j].lophocMaLH);
          if (data.list[0][i].MaLH == data.list2[0][j].lophocMaLH){
            tkb += "Thứ " +data.list2[0][j].Ngay;
            tkb += ": Từ " + data.list2[0][j].Giobatdau;
            tkb += " giờ Đến " + data.list2[0][j].Gioketthuc;
            tkb+= " Giờ <br>";
          }
        }

        table.row
          .add([
            `<center><td class="top"> ${data.list[0][i].MaLH}  </td></center>`,
            `<center ><td > ${moment(data.list[0][i].Ngaybatdau).format('l')} </td></center>`,
            `<center ><td > ${moment(data.list[0][i].Ngayketthuc).format('l')} </td></center>`,
            `<center><td> ${tkb}</td></center>`,
            `<center><td> ${data.list[0][i].Siso}</td></center>`,
            `<center><td> ${data.list[0][i].chinhanhMaCN}</td></center>`,
            `<center><td> <button type="button" class="dangkylh btn btn-primary" data-malh=${data.list[0][i].MaLH} data-makh=${data.list[0][i].khoahocMaKH}> chọn </button></td></center>`,
          ])
          .draw(false);
      }
    } else {
      var t = $('.giaotrinhofkh').DataTable({
        searching: false, // false to disable search (or any other option)
        "scrollY": "300px",
        bInfo: false,
        sStripeEven: '',
        sStripeOdd: '',
        bPaginate: false,
        bLengthChange: false,
        bFilter: true,
        // bInfo: false,
        bAutoWidth: false,
        scrollX:        true,
        // scrollCollapse: true,
        paging:         true,
        fixedColumns: true,
        columnDefs: [
          { width: 120, targets: 0 },
          { width: 150, targets: 1 },
          { width: 150, targets: 2 },
          { width: 270, targets: 3 },
          { width: 100, targets: 4 },
          { width: 170, targets: 5 },
          { width: 120, targets: 5 }
      ],
        fixedColumns: true
      });
      t.rows().remove().draw();
      for (var i = 0; i < data.list[0]; i++) {
        t.row
          .add([
            `<center><td class="top"> ${data.list[0][i].MaLH}  </td></center>`,
            `<center ><td > ${moment(data.list[0][i].Ngaybatdau).format('l')} </td></center>`,
            `<center ><td > ${moment(data.list[0][i].Ngayketthuc).format('l')} </td></center>`,
            `<center><td> ${tkb}</td></center>`,
            `<center><td> ${data.list[0][i].Siso}</td></center>`,
            `<center><td> ${data.list[0][i].chinhanhMaCN}</td></center>`,
            `<center><td> <button type="button" class="dangkylh btn btn-primary" data-malh=${data.list[0][i].MaLH} }> chọn </button></td></center>`,
          ])
          .draw(false);
      }
    }
  });
});


//  Đăng ký lớp học
$('.giaotrinhofkh').on('click', '.dangkylh', function (e) {

    var MaLH = $(this).data('malh');
    $.post('/dangkylh/dangky', { MaLH: MaLH}, function (data) {
      console.log(data.Result);
      if (data.Result != 'Succesfully!') {
        fireSweetAlert1();
      } else {
        
        fireSweetAlert();
        table = $('.giaotrinhofkh').DataTable();
        table.row($(this).parents('tr')).remove().draw();
        setTimeout(function () {
          window.location.href = "http://localhost:3000/dangkylh"; //will redirect to your blog page (an ex: blog.html)
       }, 2000);
      }
    });
  });

  function fireSweetAlert1() {
    Swal.fire({
      icon: 'info',
      title: 'Error!',
      text: 'Bug rồi không đăng ký được đâu',
    });
  }
  function fireSweetAlert() {
    Swal.fire('Good job!', 'Ok rồi đấy', 'success');}

  // Hủy đăng ký lớp học
    $('#TAB-students').on('click', '.delete', function (e) {

      var MaLH = $(this).data('mamhhuy');
      var MaHV = $(this).data('hocvien');
      // console.log(MaLH);
      $.post('/dangkylh/huydangky', { MaHV:MaHV,MaLH: MaLH}, function (data) {
        if (data.Result != 'Succesfully!') {
            console.log(data.Result);
          fireSweetAlert11();
        } else {
            fireSweetAlert();
          table = $('.giaotrinhofkh').DataTable();
          table.row($(this).parents('tr')).remove().draw();
          setTimeout(function () {
            window.location.href = "http://localhost:3000/dangkylh"; //will redirect to your blog page (an ex: blog.html)
         }, 2000);
        }
      });
    });

    function fireSweetAlert11() {
      Swal.fire({
        icon: 'info',
        title: 'Error!',
        text: 'Bug rồi không hủy đăng ký được đâu',
      });
    }

    $('#TAB-students').on('click', '.chuyenlophoc', function (e) {
      var MaKH = $(this).data('makhoahoc');
      var malophochientai = $(this).data('malophochientai');
      $("#Addsudung input[name='MaKH222']").val(MaKH);

      $.post('/dangkylh/getAlllh', { MaKH: MaKH }, function (data) {

        if ($.fn.dataTable.isDataTable('.gv_th_Modal')) {
          table = $('.gv_th_Modal').DataTable();
          table.clear().draw();
          for (var i = 0; i < data.list[0].length; i++) {

            var tkb ="";
            for (var j = 0; j < data.list2[0].length; j++){
              // console.log(data.list[0][i].MaLH, data.list2[0][j].lophocMaLH);
              if (data.list[0][i].MaLH == data.list2[0][j].lophocMaLH){
                tkb += "Thứ " +data.list2[0][j].Ngay;
                tkb += ": Từ " + data.list2[0][j].Giobatdau;
                tkb += " giờ Đến " + data.list2[0][j].Gioketthuc;
                tkb+= " Giờ <br>";
              }
            }
            var checkhientai ;
            if(malophochientai == data.list[0][i].MaLH) checkhientai = 'Lớp hiện tại'
            else {checkhientai='chọn'}
            table.row
              .add([
                `<center><td class="top"> ${data.list[0][i].MaLH}  </td></center>`,
                `<center ><td > ${moment(data.list[0][i].Ngaybatdau).format('l')} </td></center>`,
                `<center ><td > ${moment(data.list[0][i].Ngayketthuc).format('l')} </td></center>`,
                `<center><td> ${tkb}</td></center>`,
                `<center><td> ${data.list[0][i].Siso}</td></center>`,
                `<center><td> ${data.list[0][i].chinhanhMaCN}</td></center>`,
                `<center><td> <button type="button" class="dangkylh btn btn-primary" data-malophochientai=${malophochientai} data-malh=${data.list[0][i].MaLH} data-makh=${data.list[0][i].khoahocMaKH}> ${checkhientai} </button></td></center>`,
              ])
              .draw(false);
          }
        }
        else {
          var t = $('.gv_th_Modal.table').DataTable({
            searching: false, // false to disable search (or any other option)
            
            bInfo: false,
            sStripeEven: '',
            sStripeOdd: '',
            bPaginate: false,
            bLengthChange: false,
            bFilter: false,
            bAutoWidth: false,
            scrollX:        false,
            paging:         false,
            fixedColumns: false
          }); 
          t.rows().remove().draw();
          for (var i = 0; i < data.list[0].length; i++) {
            // console.log(data.list[0][i].malh);
    
            var tkb ="";
            for (var j = 0; j < data.list2[0].length; j++){
              if (data.list[0][i].MaLH == data.list2[0][j].lophocMaLH){
                tkb += "Thứ " +data.list2[0][j].Ngay;
                tkb += ": Từ " + data.list2[0][j].Giobatdau;
                tkb += " giờ Đến " + data.list2[0][j].Gioketthuc;
                tkb+= " Giờ <br>";
              }
            }
            var checkhientai ;
            if(malophochientai == data.list[0][i].MaLH) checkhientai = 'Lớp hiện tại'
            else {checkhientai='chọn'}
            t.row
              .add([
                `<center><td class="top"> ${data.list[0][i].MaLH}  </td></center>`,
                `<center ><td > ${moment(data.list[0][i].Ngaybatdau).format('l')} </td></center>`,
                `<center ><td > ${moment(data.list[0][i].Ngayketthuc).format('l')} </td></center>`,
                `<center><td> ${tkb}</td></center>`,
                `<center><td> ${data.list[0][i].Siso}</td></center>`,
                `<center><td> ${data.list[0][i].chinhanhMaCN}</td></center>`,
                `<center><td> <button type="button" class="chuyenlop btn btn-primary"data-malophochientai=${malophochientai} data-malophochcuyenden=${data.list[0][i].MaLH}  }> ${checkhientai} </button></td></center>`,
              ])
              .draw(false);
          }
        
        }
     
    });


    $('.gv_th_Modal').on('click', '.chuyenlop', function (e) {
      
      var MaLH = $(this).data('malophochcuyenden');

      var Malophientai = $(this).data('malophochientai');
      $.post('/dangkylh/chuyenlophoc', { MaLH: MaLH , Malophientai:Malophientai}, function (data) {
        console.log(data.Result);
        if (data.Result != 'Succesfully!') {
          setTimeout( Chuyenthatbai(), 1000);
         
        } else {
         
          table = $('.gv_th_Modal').DataTable();
          table.row($(this).parents('tr')).remove().draw();

          Chuyenthanhcong();
          setTimeout(function () {
            window.location.href = "http://localhost:3000/dangkylh"; //will redirect to your blog page (an ex: blog.html)
         }, 2000);
          
        }
      });
    });
    function Chuyenthatbai() {
      Swal.fire({
        icon: 'info',
        title: 'Error!',
        text: 'Bug rồi không chuyển được đâu',
      });
    }
    function Chuyenthanhcong() {
      Swal.fire('Good job!', 'Ok rồi đấy', 'success');}




















      $('#Addsudung').modal('show');
    });

    