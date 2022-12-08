$(".btn-edit").click(function (e) {

    var MaLH = $(this).data("malh");
    var Siso = $(this).data("siso");
    var MaKH = $(this).data("makh");
    var MaCN = $(this).data("macn");
    $("#Editlophoc input[name='MaLH']").val(MaLH);
    $("#Editlophoc input[name='Siso']").val(Siso);
    $("#Editlophoc select[name='MaKH']").val(MaKH).change();
    $("#Editlophoc select[name='MaCN']").val(MaCN).change();
    $('#Editlophoc').modal('show');
});

$(".btn-delete").click(function (e) {

    var id = $(this).data("malh");
    $("#Deletelophoc input[name='MaLH']").val(id);
    
    $('#Deletelophoc').modal('show');
});