
$(".thienlink").click(function (e) {
    var ma = $(this).data("makh");
    console.log(ma);
    $.post('/catalog/editup', { MaKH: ma }, function (data) {
        if(data){
            window.location.href = "product";
        }

    })
})