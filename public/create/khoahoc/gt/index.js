$('.btn-search').click(function (e) {
  var ma = $('#makh').val();
  // var td  = document.getElementsByTagName("td");
  // var j = 0 ;
  // while(td[0]){
  //     var farther = td[0].parentNode;
  //     farther.removeChild(td[0]);
  // }

  $.post('/capnhatgt/getAllgt', { MaKH: ma }, function (data) {
    $('.giaotrinhofkh').attr('style', 'display:block');
    if ($.fn.dataTable.isDataTable('.giaotrinhofkh')) {
      table = $('.giaotrinhofkh').DataTable();
      table.clear().draw();
      for (var i = 0; i < data[0].length; i++) {
        table.row
          .add([
            `<center><td> ${data[0][i].MaGT}  </td></center>`,
            `<center><td> ${data[0][i].Ten}</td></center>`,
            `<center><td> ${data[0][i].Namxuatban}</td></center>`,
            `<center><td> <button type="button" class="delete btn btn-primary "data-makh=${ma} data-magt=${data[0][i].MaGT}><i class="icon-trash menu-icon"></i> </button></td></center>`,
          ])
          .draw(false);
      }
    } else {
      var t = $('.giaotrinhofkh').DataTable({
        searching: true, // false to disable search (or any other option)
        bDestroy: false,
        bInfo: false,
        sStripeEven: '',
        sStripeOdd: '',
      });
      t.rows().remove().draw();
      for (var i = 0; i < data[0].length; i++) {
        t.row
          .add([
            `<center><td class="top"> ${data[0][i].MaGT}  </td></center>`,
            `<center><td> ${data[0][i].Ten}</td></center>`,
            `<center><td> ${data[0][i].Namxuatban}</td></center>`,
            `<center><td> <button type="button" class="delete btn btn-primary" data-makhh=${ma} data-magt=${data[0][i].MaGT}> <i class="icon-trash menu-icon"></i> </button></td></center>`,
          ])
          .draw(true);
      }
    }
  });
});
$('.giaotrinhofkh').on('click', '.delete', function (e) {
  var MaKH = $(this).data('makhh');
  var MaGT = $(this).data('magt');
  $.post('/capnhatgt/delete', { MaKH: MaKH, MaGT: MaGT }, function (data) {
    if (data == 'Khoá học phải sử dụng ít nhất 1 giáo trình.') {
      fireSweetAlert1();
    } else {
        fireSweetAlert();
      table = $('.giaotrinhofkh').DataTable();
      table.row($(this).parents('tr')).remove().draw();
    }
  });
});
$('.btn-add').click(function (e) {
  $('#Addsudung').modal('show');
});

function fireSweetAlert1() {
  Swal.fire({
    icon: 'info',
    title: 'Error!',
    text: 'Bug rồi không xóa được đâu',
  });
}
function fireSweetAlert() {
  Swal.fire('Good job!', 'Ok rồi đấy', 'success');
}
