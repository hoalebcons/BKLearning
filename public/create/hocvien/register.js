
$("#form-register-student").submit(function (e) {
    e.preventDefault();
    //Write code to check if student id is existed!
    //Camel case
    var studentemail = $("input[name='email']").val();
    console.log(studentemail);
    var form = $(this);;
    //API
    $.post("/register/checkId", { email: studentemail }, function (data) {
        console.log(data);
        if (data.status == "FOUND") {
            //alert("Đã tồn tại mã số sinh viên này!");
            fireSweetAlert1();
        }
        else {
            fireSweetAlert();
              setTimeout(function () {
                form.unbind("submit").submit();
              }, 1000);
            // console.log("NOT FOUND");

        }
    });
});
function fireSweetAlert1() {
    Swal.fire({
        icon: 'info',
        title: 'Error!',
        text: 'You clicked the button!'
    })
}
function fireSweetAlert() {
    Swal.fire(
        'Good job!',
        'You clicked the button!',
        'success'
    )
}