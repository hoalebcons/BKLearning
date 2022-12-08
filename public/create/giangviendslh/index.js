
$('#TAB-students').DataTable({
    "responsive": true, "lengthChange": false, "autoWidth": false, "searching": false,
    language: {
        url: "//cdn.datatables.net/plug-ins/1.10.25/i18n/Vietnamese.json"
    } ,
    columnDefs: [
        { orderable: false,
             targets: 5
            }
      ]
    })
    $('#TAB-students1').DataTable({
        "responsive": true, "lengthChange": false, "autoWidth": false, "searching": false,
        
        "scrollY":        "200px",
        language: {
            url: "//cdn.datatables.net/plug-ins/1.10.25/i18n/Vietnamese.json"
        } ,
        // columnDefs: [
        //     { orderable: false,
        //          targets: 2
        //         }
        //   ]
        })
        $('#TAB-students2').DataTable({
            "responsive": true, "lengthChange": false, "autoWidth": false, "searching": false,
            
            "scrollY":        "200px",
            language: {
                url: "//cdn.datatables.net/plug-ins/1.10.25/i18n/Vietnamese.json"
            } ,
            // columnDefs: [
            //     { orderable: false,
            //          targets: 2
            //         }
            //   ]
            })
